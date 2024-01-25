import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/services/firestore.dart';

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
                    builder: (context) => MyHomePage(animeItem: anime),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  anime.name,
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
          if (anime.name.toLowerCase().contains(name.toLowerCase())) {
            return GestureDetector(
              onTap: () {
                // mandar informação do anime
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(animeItem: anime),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  anime.name,
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
