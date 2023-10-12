import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteWebViewContainer extends StatefulWidget {
  const NoteWebViewContainer({super.key});

  @override
  State<NoteWebViewContainer> createState() => _NoteWebViewContainerState();
}

class _NoteWebViewContainerState extends State<NoteWebViewContainer> {
  static String sampleHtml = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <ul>
    <li><b>Microorganisms:</b>
      <ul>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems which in tern is very important for us. This is just a random text with to test lengthy paragraph. Play important roles in various ecosystems which in tern is very important for us. This is just a random text with to test lengthy paragraph.</li>
      </ul>
    </li>
    <li><b>Types:</b>
      <ul>
        <li>Bacteria:</li>
        <ul>
          <li>Single-celled prokaryotes</li>
          <li>Found virtually everywhere on Earth</li>
          <li>Some species can be harmful (pathogenic bacteria)</li>
        </ul>
        <li>Viruses:</li>
        <ul>
          <li>Obligate <mark>intracellular</mark> parasites</li>
          <li>Consist of genetic material enclosed in a protein coat</li>
          <li>Cannot reproduce without a host</li>
        </ul>
        <li>Fungi:</li>
        <ul>
          <li>Eukaryotic organisms</li>
          <li>Obtain nutrients by absorbing them from their environment</li>
          <li>Include yeasts, molds, and mushrooms</li>
        </ul>
        <ul>
    <li><b>Microorganisms:</b>
      <ul>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems which in tern is very important for us. This is just a random text with to test lengthy paragraph. Play important roles in various ecosystems which in tern is very important for us. This is just a random text with to test lengthy paragraph.</li>
      </ul>
    </li>
    <li><b>Types:</b>
      <ul>
        <li>Bacteria:</li>
        <ul>
          <li>Single-celled prokaryotes</li>
          <li>Found virtually everywhere on Earth</li>
          <li>Some species can be harmful (pathogenic bacteria)</li>
        </ul>
        <li>Viruses:</li>
        <ul>
          <li>Obligate <mark>intracellular</mark> parasites</li>
          <li>Consist of genetic material enclosed in a protein coat</li>
          <li>Cannot reproduce without a host</li>
        </ul>
        <li>Fungi:</li>
        <ul>
          <li>Eukaryotic organisms</li>
          <li>Obtain nutrients by absorbing them from their environment</li>
          <li>Include yeasts, molds, and mushrooms</li>
        </ul>
        </ul>
        </ul>
        
        
        
</body>
</html>



        
  ''';
  // WebView.platform = SurfaceAndroidWebView();
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadHtmlString(sampleHtml);
  // ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
        ),
        backgroundColor: Color.fromARGB(221, 246, 244, 244),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
