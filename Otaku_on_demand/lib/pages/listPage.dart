import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:otaku_on_demand/pages/itemPage.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //const ListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: animeList.length,
          itemBuilder: (context, index) {
            AnimeList anime = animeList[index];
            return Card(
              child: ListTile(
                title: Text(anime.title),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ItemPage()));
                },
              ),
            );
          }),
    );
  }
}
