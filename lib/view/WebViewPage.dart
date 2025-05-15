import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController();
    if (_controller.platform is AndroidWebViewController) {
      // Enable hybrid composition for Android
      final AndroidWebViewController androidController =
          _controller.platform as AndroidWebViewController;
      // androidController.setHybridComposition(true); // This method does not exist
      // No additional configuration is required here for hybrid composition
    }
    super.initState(); // Ensure the parent class's initState is called
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
      ),
      body: WebViewWidget(
        controller: _controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(widget.url)), // Load the URL passed to the widget
      ),
    );
  }
}
