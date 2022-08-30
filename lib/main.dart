import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last/webview/GetImage.dart';
import 'package:last/pages/add_edit_product.dart';
import 'package:last/pages/home_page.dart';
import 'dart:io';

import 'pages/Category.dart';
import 'pages/Layout.dart';
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Layout();
  }

}