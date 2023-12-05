import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartnote/backend/helper_function.dart';
import 'package:smartnote/backend/storage/cloud/const.dart';
import 'package:smartnote/backend/storage/cloud/cloud_database.dart';
import 'package:smartnote/backend/storage/local/local_storage.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;

Future<int> supabaseSaveNoteAndQuestion(String text) async {
  User? user = FirebaseAuth.instance.currentUser;

  final splitedText = splitText(text);

  final noteContent = splitedText[0].toString();
  final questionContent = splitedText[1].toString();
  final title = splitedText[2];

  var questionList = json.decode(questionContent);

  var random = Random();
  var randomNumber = random.nextInt(9000) + 1000;

  // final directory = await getApplicationDocumentsDirectory();

  final directory = await getApplicationDocumentsDirectory();
  final notePath =
      '${directory.path}/notes/${remove_chars(title.toString()).replaceAll(' ', '')}.html';
  final questionPath =
      '${directory.path}/questions/${remove_chars(title.toString()).replaceAll(' ', '')}.json';

  await Directory('${directory.path}/notes/').create(recursive: true);
  await Directory('${directory.path}/questions/').create(recursive: true);

  final noteFile = File(notePath);
  final questionFile = File(questionPath);
  await noteFile.writeAsString(noteContent);
  await questionFile.writeAsString(json.encode(questionList));

  // Upload files to Supabase storage
  // await client.from('YOUR_STORAGE_BUCKET').upload(notePath, utf8.encode(noteContent));

  // Create temporary files and write content to them

  print('=================uploading files to supabase=====================');
  print("note path: $notePath");
  print("question path: $questionPath");

  final userUid = retainAlphabetsOnly(user!.uid);
  final cloudNotePath =
      '$userUid/notes/${remove_chars(title.toString()).replaceAll(' ', '')}$randomNumber';

  final cloudQuestionPath =
      '$userUid/questions/${remove_chars(title.toString()).replaceAll(' ', '')}$randomNumber';
  print("cloud note path: $cloudNotePath");
  print("cloud question path: $cloudQuestionPath");

  try {
    await supabaseClient.storage
        .from('smartnote-bucket')
        .upload(cloudNotePath, noteFile);
    print("note file uploaded");
    // get download url
  } catch (e) {
    print("error in uploading note file");
    print(e);
  }

  final noteUrl = supabaseClient.storage
      .from('smartnote-bucket')
      .getPublicUrl(cloudNotePath);

  // print("==============Public file urls=============");
  // print("note url: $noteUrl");
  // print("question url: $questionUrl");

  try {
    // first create a folder on supabase storage
    await supabaseClient.storage
        .from('smartnote-bucket')
        .upload(cloudQuestionPath, questionFile)
        .then((value) {
      print("note file uploaded");
      print("value: $value");
    });
  } catch (e) {
    print("error in uploading note file");
    print(e);
  }

  final questionUrl = supabaseClient.storage
      .from('smartnote-bucket')
      .getPublicUrl(cloudQuestionPath);

  // Delete temporary files
  await noteFile
      .delete()
      .then((value) => print("note file deleted"))
      .onError((error, stackTrace) {
    print("error in deleting note file");
    print(error);
  });
  await questionFile
      .delete()
      .then((value) => print("question file deleted"))
      .onError((error, stackTrace) {
    print("error in deleting note file");
    print(error);
  });

  // Insert paths to Supabase database

  print("============inserting paths to database =====================");

  var dbHelper = SupabaseDatabaseHelper();
  try {
    await dbHelper.insertPath({
      'user_uid': userUid,
      'notes': noteUrl,
      'questions': questionUrl,
      'title': title,
    });
  } catch (e) {
    print("=====error in inserting path to database====");
    print(e);
  }

  return 1;
}
