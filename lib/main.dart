import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: " TODO AOO",
      home: const Home(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
