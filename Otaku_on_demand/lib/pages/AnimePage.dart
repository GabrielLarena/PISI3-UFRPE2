import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import '../services/assistidosProvider.dart';
import '../services/favoritosProvider.dart';
import '../services/firestore.dart';
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

  //update para o anime
  late AnimeItem updatedAnimeItem;

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
    assistidosProvider =
        Provider.of<AssistidosProvider>(context, listen: false);

    // Check if the animeItem is already in favorites
    isInList = assistidosProvider.favoritesList
        .any((item) => item.animeid == widget.animeItem.animeid);

    // You can also call getFavorites to ensure the list is up-to-date
    assistidosProvider.getData();

    updatedAnimeItem = widget.animeItem;
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
          animeItem.englishname != "UNKNOWN"
              ? animeItem.englishname
              : animeItem.name,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
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
                          favoritesProvider.removeFromFavorites(widget.animeItem
                              .animeid);
                        } else {
                          favoritesProvider.addToFavorites(widget.animeItem
                              .animeid);
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
                    children: [ ElevatedButton.icon(
                      onPressed: () async {
                        final animeDelete =
                        FirebaseFirestore.instance.collection('animeTest').doc(
                            animeItem.animeid);
                        animeDelete.delete();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.orange,
                        padding:
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                      ),
                      icon: const Icon(
                          Icons.delete
                      ),
                      label: const Text(
                        'Deletar Anime',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          //editar
                          await editAnimeDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.orange,
                          padding:
                          const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                        ),
                        icon: const Icon(
                            Icons.edit
                        ),
                        label: const Text(
                          'Editar Anime',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
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

  Future<void> editAnimeDialog(BuildContext context) async {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController englishNameController = TextEditingController();
    final TextEditingController genresController = TextEditingController();
    final TextEditingController synopsisController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController episodesController = TextEditingController();
    final TextEditingController premieredController = TextEditingController();
    final TextEditingController airedController = TextEditingController();
    final TextEditingController studiosController = TextEditingController();
    final TextEditingController sourceController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();
    final TextEditingController rankController = TextEditingController();
    final TextEditingController popularityController = TextEditingController();
    final TextEditingController favoritesController = TextEditingController();
    final TextEditingController membersController = TextEditingController();

    // Set the initial text of the controllers to the current values
    nameController.text = updatedAnimeItem.name;
    englishNameController.text = updatedAnimeItem.englishname;
    genresController.text = updatedAnimeItem.genres;
    synopsisController.text = updatedAnimeItem.synopsis;
    typeController.text = updatedAnimeItem.type;
    episodesController.text = updatedAnimeItem.episodes;
    premieredController.text = updatedAnimeItem.premiered;
    airedController.text = updatedAnimeItem.aired;
    studiosController.text = updatedAnimeItem.studios;
    sourceController.text = updatedAnimeItem.source;
    durationController.text = updatedAnimeItem.duration;
    ratingController.text = updatedAnimeItem.rating;
    rankController.text = updatedAnimeItem.rank;
    popularityController.text = updatedAnimeItem.popularity;
    favoritesController.text = updatedAnimeItem.favorites;
    membersController.text = updatedAnimeItem.members;

    // Show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Anime'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Nome', nameController),
                _buildTextField('Nome em inglês', englishNameController),
                _buildTextField('Gênero', genresController),
                _buildTextField('Sinopse', synopsisController),
                _buildTextField('Tipo (filme, anime, OVA)', typeController),
                _buildTextField('N de Episódios', episodesController),
                _buildTextField('Data de lançamento', premieredController),
                _buildTextField('Data de estreia', airedController),
                _buildTextField('Estúdio', studiosController),
                _buildTextField('Fonte', sourceController),
                _buildTextField('Duração', durationController),
                _buildTextField('Classificação indicativa', ratingController),
                _buildTextField('Rank', rankController),
                _buildTextField('Popularidade', popularityController),
                _buildTextField('Favoritos', favoritesController),
                _buildTextField('Membros', membersController),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Update the updatedAnimeItem with the new values
                updatedAnimeItem = AnimeItem(
                  name: nameController.text,
                  englishname: englishNameController.text,
                  score: updatedAnimeItem.score,
                  genres: genresController.text,
                  synopsis: synopsisController.text,
                  type: typeController.text,
                  episodes: episodesController.text,
                  premiered: premieredController.text,
                  aired: airedController.text,
                  studios: studiosController.text,
                  source: sourceController.text,
                  duration: durationController.text,
                  rating: ratingController.text,
                  rank: rankController.text,
                  popularity: popularityController.text,
                  favorites: favoritesController.text,
                  members: membersController.text,
                  imageURL: updatedAnimeItem.imageURL, // imageURL não muda
                  animeid: updatedAnimeItem.animeid, // animeid não muda
                  scoredBy: updatedAnimeItem.scoredBy, // scoredBy não muda
                );

                //update anime
                firestoreService.updateAnime(updatedAnimeItem);

                //update da pagina
                firestoreService.fetchData();

                Navigator.of(context).pop();
                Navigator.of(context).pop();// Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Helper function to build text fields for the dialog
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Digite aqui',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}