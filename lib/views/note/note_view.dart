import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnote/models/noteAndQuestion.dart';
import 'package:smartnote/backend/helper_function.dart';
import 'package:smartnote/backend/storage/local/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteView extends StatefulWidget {
  final String htmlFilePath;
  final String topicTitle;
  const NoteView(
      {required this.htmlFilePath, required this.topicTitle, Key? key})
      : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  User? user = FirebaseAuth.instance.currentUser;
  late WebViewController controller;
  
  bool isControllerInitialized = false;

  Future<String> loadHtmlFromFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  // load html content from url

  Future<void> setupWebviewContent() async {
    final htmlContent;

    if (user != null) {
      htmlContent = await fetchContentFromUrl(Uri.parse(widget.htmlFilePath));
      controller.loadHtmlString(htmlContent.toString());
    } else {
      htmlContent = await loadHtmlFromFile(widget.htmlFilePath);
      controller.loadHtmlString(htmlContent);
    }
  }

  late Future<List<DataNote>> all_data;

  Future<List<DataNote>> fetchData() async {
    var dbHelper = SqliteDatabaseHelper();
    List<Map<String, dynamic>> rawList = await dbHelper.getPaths();
    return rawList.map((dataMap) => DataNote.fromMap(dataMap)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        appBar: AppBar(
          title: Text(widget.topicTitle.trim(),
              style: themeFontFamily.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
          backgroundColor: themeColor,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.login),
            ),
          ],
        ),
        body: WebViewWidget(controller: controller,


        ));
  }

  @override
  void initState() {
    super.initState();
    
    controller =
        WebViewController(); // Assuming WebViewWidget provides a default constructor
    isControllerInitialized = true;
    setupWebviewContent();
    all_data = fetchData();
  }
}
