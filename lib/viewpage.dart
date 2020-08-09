import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPage extends StatefulWidget {
  final String url;
  ViewPage(this.url);
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
      )
    );
  }
}