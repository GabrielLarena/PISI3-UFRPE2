import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});
  //final AnimeList animeList;

  //ItemPage(this.animeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9029fb),
        title: Text('Listas'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: animeCheck.length,
          itemBuilder: (context, index) {
            AnimeItem anime = animeCheck[index];
            return Card(
              child: ListTile(
                title: Text(anime.name),
                leading: Image.network(anime.imageURL),
                //trailing: Icon(Icons.arrow_forward_rounded),
              ),
            );
          }),
    );
  }
}
