
import 'dart:io';
import 'package:http/http.dart' as http;

class OpenAI {
  final String apiKey = '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';

  Future<String> transcribeAudio(String audioFilePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://api.openai.com/v1/engines/whisper-1/transcriptions'));
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
