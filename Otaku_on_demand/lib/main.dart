import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Otaku on demand",
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 118, 112, 134),
      ),
      home: StartPage(),
    );
  }
}
