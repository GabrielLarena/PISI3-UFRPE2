
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:otaku_on_demand/services/favoritosProvider.dart';
import 'package:otaku_on_demand/services/assistidosProvider.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreService = FirestoreService();
  final favoritesProvider = FavoritesProvider();
  final assistidosProvider = AssistidosProvider();
  await firestoreService.fetchData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: firestoreService,
        ),
        ChangeNotifierProvider.value(
          value: favoritesProvider,
        ),
        ChangeNotifierProvider.value(
          value: assistidosProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // root
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Otaku on demand",
        home: StartPage(),
    );
  }
}
