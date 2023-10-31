import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartnote/services/helper_function.dart';
import 'package:smartnote/services/storage/local/local_storage.dart';

Future<int> firebaseSaveNoteAndQuestion(String text) async {
  User? user = FirebaseAuth.instance.currentUser;
  final splitedText = splitText(text);
  if (splitedText.length < 3) {
    print("ERROR IN SPLITTING TEXT");
    return -1; // Error code
  }

  final noteContent = splitedText[0].toString();
  final questionContent = splitedText[1].toString();
  final title = splitedText[2];

  var random = Random();
  var randomNumber = random.nextInt(9000) + 1000;

  final directory = await getApplicationDocumentsDirectory();
  final notePath =
      '${directory.path}/notes/${remove_chars(title).replaceAll(' ', '')}.html';
  final questionPath =
      '${directory.path}/questions/${remove_chars(title).replaceAll(' ', '')}.json';

  await Directory('${directory.path}/notes/').create(recursive: true);
  await Directory('${directory.path}/questions/').create(recursive: true);

  final noteFile = File(notePath);
  final questionFile = File(questionPath);
  await noteFile.writeAsString(noteContent);
  await questionFile.writeAsString(json.encode(questionContent));

  final userUid = retainAlphabetsOnly(user!.uid);
  final cloudNotePath =
      '$userUid/notes/${remove_chars(title).replaceAll(' ', '')}$randomNumber.html';
  final cloudQuestionPath =
      '$userUid/questions/${remove_chars(title).replaceAll(' ', '')}$randomNumber.json';

  // Upload files to Firebase Storage
  var storageRef = FirebaseStorage.instance.ref();
  try {
    await storageRef.child(cloudNotePath).putFile(noteFile);
    await storageRef.child(cloudQuestionPath).putFile(questionFile);

    print("Files uploaded to Firebase Storage");
  } catch (e) {
    print("Error uploading files to Firebase Storage: $e");
    return -1; // Error code
  }

  // Get download URLs
  final noteUrl = await storageRef.child(cloudNotePath).getDownloadURL();
  final questionUrl =
      await storageRef.child(cloudQuestionPath).getDownloadURL();

  // Delete temporary files
  await noteFile.delete();
  await questionFile.delete();

  // Insert paths to Firestore (or Realtime Database)
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    await db.collection('user_notes').add({
      'user_uid': userUid,
      'note_url': noteUrl,
      'question_url': questionUrl,
      'title': title,
    });
    print("Data added to Firestore");
  } catch (e) {
    print("Error adding data to Firestore: $e");
    return -1; // Error code
  }

  return 1; // Success code
}

Future<bool> deleteNote(
    String noteId, String storageNotePath, String storageQuestionPath) async {
  try {
    // Delete from Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref(storageNotePath).delete();
    await storage.ref(storageQuestionPath).delete();
    print('Note and Question files deleted from Firebase Storage.');

    // Delete the metadata from Firestore
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('user_notes').doc(noteId).delete();
    print('Note metadata deleted from Firestore.');

    return true; // Successfully deleted
  } catch (e) {
    print('Error deleting note: $e');
    return false; // Deletion failed
  }
}
