import 'package:flutter/material.dart';
import 'package:smartnote/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoteWebViewContainer extends StatefulWidget {
  const NoteWebViewContainer({super.key});

  @override
  State<NoteWebViewContainer> createState() => _NoteWebViewContainerState();
}

class _NoteWebViewContainerState extends State<NoteWebViewContainer> {
  static String sampleHtml =
      '''
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
      <ul>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems</li>
      </ul>
    
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

        <ul>
          <h3><u>Examples:</u></h3>
          <li>Streptococcus</li>
          <li>Staphylococcus</li>
          <li>Escherichia coli</li>
          <li>Coronavirus</li>
          <li>Human immunodeficiency virus (HIV)</li>
          <li>Human papillomavirus (HPV)</li>
          <li>Aspergillus</li>
          <li>Candida</li>
          <li>Penicillium</li>
          </ul>


          <ul>
        <li>Small living organisms not visible to the naked eye</li>
        <li>Wide variety of species</li>
        <li>Play important roles in various ecosystems</li>
      </ul>
    
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

        <ul>
          <h3><u>Examples:</u></h3>
          <li>Streptococcus</li>
          <li>Staphylococcus</li>
          <li>Escherichia coli</li>
          <li>Coronavirus</li>
          <li>Human immunodeficiency virus (HIV)</li>
          <li>Human papillomavirus (HPV)</li>
          <li>Aspergillus</li>
          <li>Candida</li>
          <li>Penicillium</li>
          </ul>
      </ul>
        
</body>
</html>


        
  ''';

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadHtmlString(sampleHtml);

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
              height: 1000, // You can adjust the height as needed
              child: WebViewWidget(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
