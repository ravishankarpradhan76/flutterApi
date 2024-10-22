import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Sign_Up.dart';
import 'package:flutter_app/pages/Post_Api_Practice.dart';
import 'package:flutter_app/pages/Post_Api_Revision.dart';
import 'package:flutter_app/pages/get_Api_practice.dart';
import 'package:flutter_app/pages/signUp.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:SignUp(),
    );
  }
}

