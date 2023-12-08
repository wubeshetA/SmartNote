import 'package:webview_flutter/webview_flutter.dart';

abstract class WebViewInterface {
  Future<void> loadHtmlString(String html);
  void setController(WebViewController controller);
}
