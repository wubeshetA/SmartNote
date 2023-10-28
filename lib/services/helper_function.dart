import 'package:http/http.dart' as http;

String remove_chars(String str) {
  return str.replaceAll(RegExp(r'[^a-zA-Z]'), '');
}

String retainAlphabetsOnly(String input) {
  return input.replaceAll(RegExp(r'[^a-zA-Z]'), '');
}


  Future<String?> fetchContentFromUrl(Uri uri) async {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // If server returns an OK response, return the body as a string.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // print an error message and return null.
      print('Failed to load content with status code ${response.statusCode}');
      return null;
    }
  }