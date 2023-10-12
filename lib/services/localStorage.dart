import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'dart:convert';

import 'package:smartnote/services/storage/sqlite_db_helper.dart';

List<String> splitText(String text) {
  return text.split("----------");
}

Future<String> readFileContent(String filePath) async {
  // read the content from filePath as a string
  // Create a File object
  var file = File(filePath);
  String content = "";
  // Use the readAsString() method to read the file content as a string
  try {
    String content = await file.readAsString();
    print('File content: $content');
  } catch (e) {
    print('Error reading file: $e');
  } finally {}
  return content;
}



void saveNoteAndQuestion(String text) async {
  final splitedText = splitText(text);
  final noteContent = splitedText[0].toString();
  var questionContent = splitedText[1].toString();
  final title = splitedText[2];
  print("====================splited content ====================");
  print(questionContent);
  print("type of question: ${questionContent.runtimeType}");
  print("===========");
  print(noteContent);
  print("================================");
  print(title);
  print("====================splited content ends here ====================");
  var questionList = json.decode(questionContent);

  final directory = await getApplicationDocumentsDirectory();
  var random = Random();
  var randomNumber = random.nextInt(9000) + 1000;

  String remove_chars(String str) {
    // remove all non-alphabet characters from str
    return str.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  final notePath =
      '${directory.path}/notes/${remove_chars(title.toString()).replaceAll(' ', '')}${randomNumber.toString()}.html';
  final questionPath =
      '${directory.path}/questions/${remove_chars(title.toString()).replaceAll(' ', '')}${randomNumber.toString()}.json';

  // save to paths to sqlite database
  var dbHelper = SqliteDatabaseHelper();

// Insert data
  await dbHelper.insertPath({
    'notes': notePath,
    'questions': questionPath,
    'title': title,
  }).then((value) async {
    await Directory('${directory.path}/notes/').create(recursive: true);
    await Directory('${directory.path}/questions/').create(recursive: true);

    final noteFile = File(notePath);
    final questionFile = File(questionPath);
    await noteFile.writeAsString(noteContent);
    await questionFile.writeAsString(json.encode(questionList));

    print("============ SAVE ALL DATAS SUCCESSFULLY =============");
    print("Note Path $notePath");
    print("Question Path $questionPath");
    print("============== Here are all the database content==================");
    print(await dbHelper.getPaths());

    print("======================= Save all log ends here ================");
  });
}



