import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final OPENAI_API_KEY = dotenv.env['OPENAI_API_KEY']!;
const openaiApiUrl = 'https://api.openai.com/v1/chat/completions';

Future<String> generateContent(String prompt, String content) async {
  var url = Uri.parse(openaiApiUrl);

  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer $OPENAI_API_KEY' // Replace with your actual OpenAI API Key
  };

  var body = jsonEncode({
    'model': 'gpt-3.5-turbo',
    // 'model': 'gpt-4',
    'messages': [
      {
        'role': 'system',
        'content': prompt
        // Replace with the actual content
      },
      {
        'role': 'user',
        'content': content
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
