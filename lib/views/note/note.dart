import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:smartnote/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteWebViewContainer extends StatefulWidget {
  final String htmlFilePath;
  const NoteWebViewContainer({required this.htmlFilePath, Key? key})
      : super(key: key);

  @override
  State<NoteWebViewContainer> createState() => _NoteWebViewContainerState();
}

class _NoteWebViewContainerState extends State<NoteWebViewContainer> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled);

  Future<String> loadHtmlFromAsset(String assetPath) async {
    return await rootBundle.loadString(assetPath);
  }

  Future<void> setupWebviewContent() async {
    String htmlContent = await loadHtmlFromAsset(widget.htmlFilePath);
    controller.loadHtmlString(htmlContent);
  }

  @override
  void initState() {
    super.initState();
    setupWebviewContent();
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
              child: WebViewWidget(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
