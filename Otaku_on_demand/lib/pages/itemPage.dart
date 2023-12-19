import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animes.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});
  //final AnimeList animeList;

  //ItemPage(this.animeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
        itemCount: animeItem.length, 
        itemBuilder: (context, index) {
        AnimeItem anime = animeItem[index];
        return Card(
          child: ListTile(
            title: Text(anime.title),
            leading: Image.network(anime.imageUrl),
            //trailing: Icon(Icons.arrow_forward_rounded),
          ),
        );
      }),
    );
  }
}