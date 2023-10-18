import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartnote/services/storage/sqlite_db_helper.dart';
import 'package:smartnote/theme.dart';
import 'package:smartnote/views/note/notes_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteView extends StatefulWidget {
  final String htmlFilePath;
  final String topicTitle;
  const NoteView({required this.htmlFilePath, required this.topicTitle, Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
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
              title: Text(widget.topicTitle.toString()),
              background: Container(color: themeColor),
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
