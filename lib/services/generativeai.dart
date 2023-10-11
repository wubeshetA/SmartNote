import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final OPENAI_API_KEY = dotenv.env['OPENAI_API_KEY']!;
const openaiApiUrl = 'https://api.openai.com/v1/chat/completions';

const noteGeneratorPrompt = '''
The user enters a transcribed unstructured text from a classroom lecture, YouTube educational video, etc. 
    Your job is to generate a well structured short notes (important summaries) of the content that would help the student prepare for the exam regarding the educational content.
    Format your response as follows.

Return the short notes inside of HTML file format. Please do not  add any extra characters, words, or sentences apart from the html in the response.


this is how the html content should be returned.
Use different HTML tags to better the output of the HTML such as the 'b' tag to make time bold, the 'mark' tag to highlight important words or phrases, and also use header tags. And also use a nested ul list for list of notes under a topic. put the title of the short note in a <h2> tag.



Here is an example of how html content should look like and you should add all the head content from the example to your response. only change the content based on the example.


``` 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
  
    body > ul {
      padding: 0;
      margin: 20px;
    }
    body > ul > * {
      padding: 5px;

    }
    h2 {
      text-align: center;
    }
    </style>
</head>
<body>
  <ul>
    <h2>Microorganisms</h2>
      <ul>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems</li>
      </ul>
    </li>
    
      <ul>
        <h3><u>Types:</u></h3>
        <li>Bacteria:</li>
        <ul>
          <li>Single-celled prokaryotes</li>
          <li>Found virtually everywhere on Earth</li>
          <li>Some species can be harmful (pathogenic bacteria)</li>
        </ul>
        <li>Viruses:</li>
        <ul>
          <li>Obligate <mark>intracellular</mark> parasites</li>
          <li>Consist of genetic material enclosed in a protein coat</li>
          <li><mark>Cannot reproduce</mark> without a host</li>
        </ul>
        <li>Fungi:</li>
        <ul>
          <li>Eukaryotic organisms</li>
          <li>Obtain nutrients by absorbing them from their environment</li>
          <li>Include yeasts, molds, and mushrooms</li>
        </ul>
        
</body>
</html>

```

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
    'model': 'gpt-3.5-turbo',
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
    'max_tokens': 256,
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
