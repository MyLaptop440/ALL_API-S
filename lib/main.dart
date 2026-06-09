import 'package:flutter/material.dart';
import 'package:flutter_application_23/crud_app/home_page.dart';
//import 'package:flutter_application_23/get_api.dart';
//import 'package:flutter_application_23/update.dart';
//import 'package:flutter_application_23/post_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: home_page(),
    );
  }
}
