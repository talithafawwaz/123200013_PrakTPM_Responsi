import 'package:responsi_123200013/view/auth/login_page.dart';
import 'package:flutter/material.dart';

import './view/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.light().copyWith(primary: Colors.tealAccent),
      ),
      home: const LoginPage(),
    );
  }
}
