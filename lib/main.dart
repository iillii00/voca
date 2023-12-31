import 'package:flutter/material.dart';

import 'sreens/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Our Voca",
      home: LoginPage(),
    );
  }
}
