import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/pages/listProvider.dart';
import 'package:otaku_on_demand/services/firestore.dart';

import '../services/favoritosProvider.dart';
//import 'package:otaku_on_demand/model/animemodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: HomePageList(),
          ),
        ),
      ),
    );
  }
}

class HomePageList extends StatefulWidget {
  const HomePageList({super.key});

  @override
  _HomePageListState createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    favoritesProvider.getFavorites();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Animes Populares",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 350.0,
          child: ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            itemCount: firestoreService.animeDataList.length,
            itemBuilder: (context, index) {
              final anime = firestoreService.animeDataList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 210,
                      child: Text(
                        anime.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // mandar informação do anime
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(
                                  animeItem: anime,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 210,
                        height: 300,
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
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            const Text(
              "Animes Favoritos",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        favoritesProvider.favoritesList.isEmpty
            ? const Center(
            // Display a message when the favorites list is empty
             child: Text('Lista de favoritos esta vazia \n Adicione mais animes!'),
            )
            :SizedBox(
            height: 350.0,
            child: ListView.builder(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            itemCount: favoritesProvider.favoritesList.length,
            itemBuilder: (context, index) {
              final anime = favoritesProvider.favoritesList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 210,
                      child: Text(
                        anime.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // mandar informação do anime
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(
                                  animeItem: anime,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 210,
                        height: 300,
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
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  }