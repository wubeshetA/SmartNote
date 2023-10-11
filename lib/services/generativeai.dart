
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAI {
  final String apiKey = dotenv.env['OPENAI_API_KEY']!;



  Future<String> transcribeAudio(String audioFilePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://api.openai.com/v1/audio/transcriptions'));
    request.headers.addAll({
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'multipart/form-data',
    });
    request.files.add(await http.MultipartFile.fromPath('audio', audioFilePath));
    var response = await request.send();
    if (response.statusCode == 200) {
      var result = await http.Response.fromStream(response);
      return result.body;
    } else {
      throw Exception('Failed to transcribe audio');
    }
  }




}
