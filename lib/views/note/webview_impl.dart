import 'webview_interface.dart'; // Import the interface
import 'package:webview_flutter/webview_flutter.dart';

class WebViewImpl implements WebViewInterface {
  late WebViewController _controller;

  WebViewImpl();

  @override
  Future<void> loadHtmlString(String html) async {
    await _controller.loadHtmlString(html);
  }

  @override
  void setController(WebViewController controller) {
    _controller = controller;
  }
}
