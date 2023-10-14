import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class NoteWebViewContainer extends StatefulWidget {
  final String htmlFile;

  const NoteWebViewContainer({Key? key, required this.htmlFile})
      : super(key: key);

  @override
  State<NoteWebViewContainer> createState() => _NoteWebViewContainerState();
}

class _NoteWebViewContainerState extends State<NoteWebViewContainer> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Color.fromARGB(221, 246, 244, 244),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebView(
        initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          controller = webViewController;
          _loadHtmlFile();
        },
      ),
    );
  }

  void _loadHtmlFile() async {
    String fileContents =
        await DefaultAssetBundle.of(context).loadString(widget.htmlFile);
    controller.loadUrl(Uri.dataFromString(
      fileContents,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }
}
