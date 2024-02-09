import 'package:flutter/material.dart';

//import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import '../services/assistidosProvider.dart';
import '../services/favoritosProvider.dart';

class ItemPage extends StatefulWidget {
  final list;

  const ItemPage({required this.list, Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

//final AnimeList animeList;

//ItemPage(this.animeList);

class _ItemPageState extends State<ItemPage> {
  late dynamic provider;

  @override
  void initState() {
    super.initState();

    // mudar o provider dependendo to tipo da 'list'
    if (widget.list == 'Favoritos') {
      provider = Provider.of<FavoritesProvider>(context, listen: false);
    } else if (widget.list == 'Assistir mais tarde') {
      provider = Provider.of<AssistidosProvider>(context, listen: false);
    }

    // geData do provider
    provider.getData();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    favoritesProvider.getData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9029fb),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.list == 'Favoritos' ? 'Favoritos' : 'Assistir mais tarde',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
      body: provider.favoritesList.isEmpty
          ? Center(
        // mensagem quando a lista estiver vazia
        child: Text(
          'Lista está vazia',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : ListView.builder(
          itemCount: provider.favoritesList.length,
          itemBuilder: (context, index) {
            final anime = provider.favoritesList[index];
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
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          anime.imageURL,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              anime.englishname != "UNKNOWN"
                                  ? anime.englishname
                                  : anime.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Score: ${anime.score}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
