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

    // Initialize the provider based on the value of 'list'
    if (widget.list == 'Favoritos') {
      provider = Provider.of<FavoritesProvider>(context, listen: false);
    } else if (widget.list == 'Assistir mais tarde') {
      provider = Provider.of<AssistidosProvider>(context, listen: false);
    }

    // Fetch data from the provider
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
        title: Text(widget.list == 'Favoritos' ? 'Favoritos' : 'Assistir mais tarde',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,),
        ),
      ),
      body: provider.favoritesList.isEmpty
          ? const Center(
          // Display a message when the favorites list is empty
            child: Text('Lista de favoritos esta vazia'),
          )
          :GridView.builder(
                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                       maxCrossAxisExtent: 220,
                       childAspectRatio: 3 / 2,
                       crossAxisSpacing: 20,
                       mainAxisSpacing: 20),
                       itemCount: provider.favoritesList.length,
                   itemBuilder: (context, index) {
                     final anime = provider.favoritesList[index];
                     return GestureDetector(
                       onTap: () {
                         // mandar informação do anime
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => AnimeDetailPage(
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
