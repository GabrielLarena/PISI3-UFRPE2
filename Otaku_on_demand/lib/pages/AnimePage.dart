import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import '../services/assistidosProvider.dart';
import '../services/favoritosProvider.dart';
import 'package:provider/provider.dart';

class AnimeDetailPage extends StatefulWidget {
  final AnimeItem animeItem;

  const AnimeDetailPage({required this.animeItem, Key? key}) : super(key: key);

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late FavoritesProvider favoritesProvider;
  late AssistidosProvider assistidosProvider;
  bool isFavorite = false;
  bool isInList = false;

  @override
  void initState() {
    super.initState();

    // Access the FavoritesProvider
    favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    // Check if the animeItem is already in favorites
    isFavorite = favoritesProvider.favoritesList
        .any((item) => item.animeid == widget.animeItem.animeid);

    // You can also call getFavorites to ensure the list is up-to-date
    favoritesProvider.getData();

    // Access the FavoritesProvider
    assistidosProvider = Provider.of<AssistidosProvider>(context, listen: false);

    // Check if the animeItem is already in favorites
    isInList = assistidosProvider.favoritesList
        .any((item) => item.animeid == widget.animeItem.animeid);

    // You can also call getFavorites to ensure the list is up-to-date
    assistidosProvider.getData();

  }

  @override
  Widget build(BuildContext context) {
    AnimeItem animeItem = widget.animeItem;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          animeItem.englishName != "UNKNOWN"
              ? animeItem.englishName
              : animeItem.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(animeItem.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (isFavorite) {
                          favoritesProvider
                              .removeFromFavorites(widget.animeItem);
                        } else {
                          favoritesProvider.addToFavorites(widget.animeItem);
                        }
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.orange,
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        isFavorite
                            ? 'Remover dos Favoritos'
                            : 'Adicionar aos Favoritos',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (isInList) {
                          assistidosProvider
                              .removeFromAssistir(widget.animeItem);
                        } else {
                          assistidosProvider.addToAssistir(widget.animeItem);
                        }
                        setState(() {
                          isInList = !isInList;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.orange,
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      icon: Icon(
                        isInList
                            ? Icons.playlist_add_check_rounded
                            : Icons.playlist_add_rounded,
                      ),
                      label: Text(
                        isInList
                          ? 'Remover do Assistir mais tarde'
                          : 'Assistir mais tarde',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Generos:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    animeItem.genres,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sinopsis:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    animeItem.synopsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn('Episodios', animeItem.episodes),
                      _buildInfoColumn('Nota', animeItem.score),
                      _buildInfoColumn('Favoritos', animeItem.favorites),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}