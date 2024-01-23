import 'package:flutter/material.dart';
//import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/services/firestore.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  _ItemPageState createState() => _ItemPageState();
}

//final AnimeList animeList;

  //ItemPage(this.animeList);

class _ItemPageState extends State<ItemPage> {

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9029fb),
        title: const Text('Lista'),
      ),
      body: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                       maxCrossAxisExtent: 220,
                       childAspectRatio: 3 / 2,
                       crossAxisSpacing: 20,
                       mainAxisSpacing: 20),
                       itemCount: firestoreService.animeDataList.length,
                   itemBuilder: (context, index) {
                     final anime = firestoreService.animeDataList[index];
                     return GestureDetector(
                       onTap: () {
                         // mandar informação do anime
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => MyHomePage(
                                 animeItem:
                                 anime),
                           ),
                         );
                       },
                       child: Card(
                         child: ListTile(title: Text(anime.name),
                           leading: Image.network( anime.imageURL),
                         ),
                       ),
                     );
                   }),
    );
  }
}
