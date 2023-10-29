import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Transcribe the audio file to text using Google Speech-to-Text
Future<String> transcribeAudio(String fileName) async {
  // Load audio

  print("=============Transcribing:  $fileName===========");
  final audio = File(fileName).readAsBytesSync().toList();
  final apiKey = dotenv.env['OPENAI_API_KEY']!;
  var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
  request.fields["model"] = 'whisper-1';
  request.fields["language"] = "en";
  request.files.add(await http.MultipartFile.fromPath('file', fileName));
  var response = await request.send();
  var newresponse = await http.Response.fromStream(response);
  final responseData = json.decode(newresponse.body);

  return responseData['text'];
}
