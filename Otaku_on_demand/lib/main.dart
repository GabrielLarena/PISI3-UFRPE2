import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
