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
  <style>
  
    body > ul {
      padding: 0;
      margin: 20px;
    }
    body > ul > * {
      padding: 5px;

    }
    h2 {
      text-align: center;
    }
    </style>
</head>
<body>
  <ul>
    <h2>Microorganisms</h2>
      <ul><!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
          
            body > ul {
              padding: 0;
              margin: 20px;
            }
            body > ul > * {
              padding: 5px;
        
            }
            h2 {
              text-align: center;
            }
            </style>
        </head>
        <body>
          <ul>
            <h2>Microorganisms</h2>
              <ul>
                <li>Organisms are living entities</li>
                <li>There are different types of organisms</li>
                <li>Microorganisms are very small and often referred to as germs or microbes</li>
                <li>Microorganisms can only be observed using microscopes</li>
                <li>Microorganisms play a significant role in various aspects of life</li>
              </ul>
            </li>
          </ul>
        </body>
        </html>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems</li>
      </ul>
    </li>
    
      <ul>
        <h3><u>Types:</u></h3>
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
          <li><mark>Cannot reproduce</mark> without a host</li>
        </ul>
        <li>Fungi:</li>
        <ul>
          <li>Eukaryotic organisms</li>
          <li>Obtain nutrients by absorbing them from their environment</li>
          <li>Include yeasts, molds, and mushrooms</li>
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
      
      body: WebViewWidget(controller: controller),
    );
  }
}
