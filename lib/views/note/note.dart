import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/note/notes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteWebViewContainer extends StatefulWidget {
  final String htmlFilePath;
  const NoteWebViewContainer({required this.htmlFilePath, Key? key})
      : super(key: key);

  @override
  State<NoteWebViewContainer> createState() => _NoteWebViewContainerState();
}

class _NoteWebViewContainerState extends State<NoteWebViewContainer> {
  late WebViewController controller;
  bool isControllerInitialized = false;

  Future<String> loadHtmlFromFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  Future<void> setupWebviewContent() async {
    String htmlContent = await loadHtmlFromFile(widget.htmlFilePath);
    controller.loadHtmlString(htmlContent);
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Notes'),
              background: Container(color: bgColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000, // Adjust as needed
              child: isControllerInitialized
                  ? WebViewWidget(controller: controller)
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
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
