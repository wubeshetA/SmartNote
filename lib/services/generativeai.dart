import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

final OPENAI_API_KEY = dotenv.env['OPENAI_API_KEY']!;
final OPENAI_API_URL = 'https://api.openai.com/v1/chat/completions';

Future<String> generateNote(String transcribedRawText) async {
  var url = Uri.parse(OPENAI_API_URL);
  var note_generator_prompt = await rootBundle
      .loadString('assests/note_generator_prompt.txt')
      .toString();

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
        'content': note_generator_prompt
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
  var generatedNote =
      await jsonDecode(response.body)['choices'][0]['message']['message'];
  if (response.statusCode == 200) {
    print("=============================Generated Note===============");
    print(generatedNote);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  return generatedNote;
}