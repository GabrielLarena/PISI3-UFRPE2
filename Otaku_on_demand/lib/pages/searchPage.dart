//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import '../services/favoritosProvider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  String name = "";

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Procura por nome'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
        backgroundColor: const Color(0xff9029fb),
      ),
      body: ListView.builder(
        itemCount: firestoreService.animeDataList.length,
        itemBuilder: (context, index) {
          final anime = firestoreService.animeDataList[index];

          //resultado vazio
          if (name.isEmpty) {
            return GestureDetector(
              onTap: () {
                // mandar informação do anime
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimeDetailPage(animeItem: anime),
                  ),
                );
              },
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                  favoritesProvider.favoritesList
                      .any((item) => item.animeid == anime.animeid)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.orange,
                ),
                  onPressed: () {
                    // Check if the animeItem is already in favorites
                    if (favoritesProvider.favoritesList
                        .any((item) => item.animeid == anime.animeid)) {
                      // Remove from favorites
                      favoritesProvider.removeFromFavorites(anime.animeid);
                    } else {
                      // Add to favorites
                      favoritesProvider.addToFavorites(anime.animeid);
                    }
                  },
                ),
                title: Text(
                  anime.englishname != "UNKNOWN"
                      ? anime.englishname
                      : anime.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  anime.genres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 52.5,
                    minHeight: 75,
                    maxWidth: 105,
                    maxHeight: 150,
                  ),
                  child: Image.network( anime.imageURL, fit: BoxFit.cover),
                )
              ),
            );
          }
          if (anime.name.toLowerCase().contains(name.toLowerCase())) {
            return GestureDetector(
              onTap: () {
                // mandar informação do anime
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimeDetailPage(animeItem: anime),
                  ),
                );
              },
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(
                    favoritesProvider.favoritesList
                        .any((item) => item.animeid == anime.animeid)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    // Check if the animeItem is already in favorites
                    if (favoritesProvider.favoritesList
                        .any((item) => item.animeid == anime.animeid)) {
                      // Remove from favorites
                      favoritesProvider.removeFromFavorites(anime.animeid);
                    } else {
                      // Add to favorites
                      favoritesProvider.addToFavorites(anime.animeid);
                    }
                  },
                ),
                title: Text(
                  anime.englishname != "UNKNOWN"
                      ? anime.englishname
                      : anime.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  anime.score,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                leading: Container(
                  margin: const EdgeInsets.all(10),
                  width: 105,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        anime.imageURL,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
