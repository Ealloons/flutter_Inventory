import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class GetWebView extends StatelessWidget {
  final String url;
  const GetWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Web View')),
          body: WebView(initialUrl: url, javascriptMode: JavascriptMode.unrestricted,)
      ),
    );
  }
}
