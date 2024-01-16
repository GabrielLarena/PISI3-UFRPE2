import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
        providers: [
          Provider<FirestoreService>(
            create: (_) => FirestoreService(),
          ),
        ],
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
         title: "Otaku on demand",
         home: StartPage(),
       ),);
  }
}
