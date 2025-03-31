import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:Concert/models/conss.dart';  // เพิ่มการ import ของ conss.dart
import 'package:Concert/page/home/home_page.dart';  // import HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {

        getCurrentTag();
    return MaterialApp(
      title: 'CONCON',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 6, 8, 45),
          //brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 4, 12, 19),
      ),
      home: const HomePage(),  // หน้าเริ่มต้น
    );
  }
}
