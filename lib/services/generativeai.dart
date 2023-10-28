import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final OPENAI_API_KEY = dotenv.env['OPENAI_API_KEY']!;
const openaiApiUrl = 'https://api.openai.com/v1/chat/completions';

const noteGeneratorPrompt = '''
The given text is a transcription of the audio recording of educational content.
Generate shortnotes(summaries) from the text that will be important for students to prepare for exams regarding the topic.
Format the notes using different html tags such as <b>, <mark>, heardings, <ul> to make the notes well strucuture and emphasis on important words and phrases. There should be at least 2 important words or phrases with <mark> tag. After the notes add "----------" as separator on a new line and generate five to ten questions relevant to the content in JSON format. After the questions add "----------" on a new line and add a title for the note.

Example Output:

<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
<body>
  <style>body > ul {padding: 0; margin: 20px;} body > ul > * {padding: 5px;} h2 {text-align: center;}</style>
  <ul>
    <h2>Topic</h2>
    <ul>
        <li><b>Point 1</b></li>
        <li><mark>Point 2</mark></li>
        
    </ul>
    <ul>
    <h3>Subtopic</h3>
        <li><b>Point 3</b></li>

        <li><mark>Point 4</mark></li>
  </ul>
</body>
</html>
----------
[
  {"question": "Q1?", "answer": "A1"},
  {"question": "Q2?", "answer": "A2"}
]
----------
Title

''';
Future<String> generateNote(String transcribedRawText) async {
  var url = Uri.parse(openaiApiUrl);
  // var noteGeneratorPrompt = await rootBundle
  //     .loadString('assets/note_generator_prompt.txt')
  //     .toString();

  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer $OPENAI_API_KEY' // Replace with your actual OpenAI API Key
  };

  var body = jsonEncode({
    // 'model': 'gpt-3.5-turbo',
    'model': 'gpt-4',
    'messages': [
      {
        'role': 'system',
        'content': noteGeneratorPrompt
        // Replace with the actual content
      },
      {
        'role': 'user',
        'content': transcribedRawText
        // Replace with the actual content
      }
    ],
    'temperature': 1,
    'max_tokens': 1000,
    'top_p': 1,
    'frequency_penalty': 0,
    'presence_penalty': 0
  });

  var response = await http.post(url, headers: headers, body: body);
  var data = await jsonDecode(response.body);
  var generatedNote = data['choices'][0]['message']['content'];
  if (response.statusCode == 200) {
    print(data);
    print("=============================Generated Note===============");
    print(generatedNote);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  return generatedNote;
}



//   var paths = await dbHelper.getPaths();
//   print(paths);
