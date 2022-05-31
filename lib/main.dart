import 'dart:async';
import 'package:reapply_dates/reapply.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: VisaDatesApp(),
    ),
  );
}

String userDate = '';
String userToken = '';
String userID = '';

class VisaDatesApp extends StatefulWidget {
  const VisaDatesApp({super.key});

  @override
  State<VisaDatesApp> createState() => _VisaDatesAppState();
}

class _VisaDatesAppState extends State<VisaDatesApp> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReapplyPage(controller: controller),
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 68, 247, 229),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 68, 247, 229),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.primary,
        ),
        primarySwatch: Colors.cyan,
        useMaterial3: true,
      ),
    );
  }
}
