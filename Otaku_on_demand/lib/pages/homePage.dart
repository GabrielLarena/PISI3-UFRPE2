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

    favoritesProvider.getData();
    firestoreService.fetchData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "ANIMES POPULARES",
              style: TextStyle(
                color: Color(0xff9029fb),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
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
                        anime.englishname != "UNKNOWN"
                            ? anime.englishname
                            : anime.name,
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
                            builder: (context) => AnimeDetailPage(
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
        const Divider(),
        Row(
          children: [
            const Text(
              "ANIMES FAVORITOS",
              style: TextStyle(
                color: Color(0xff9029fb),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
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
                // Mensagem quando a lista de favoritos estiver vazia
                child: Text(
                  'Lista de favoritos esta vazia \n Adicione mais animes!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : SizedBox(
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
                              anime.englishname != "UNKNOWN"
                                  ? anime.englishname
                                  : anime.name,
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
                                  builder: (context) => AnimeDetailPage(
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
        FloatingActionButton(
          onPressed: () {
            _mostrarPopUpSalvarAnime(context);
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
  void _mostrarPopUpSalvarAnime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final firestoreService = Provider.of<FirestoreService>(context, listen: false);

        List<String> inputs = [
          "Nome do anime",
          "Nome em inglês",
          "Nota",
          "Gênero",
          "Sinopse",
          "Tipo (filme, anime, OVA)",
          "N de Episódios",
          "Data de lançamento",
          "Data de estreia",
          "Estúdio",
          "Fonte",
          "Duração",
          "Classificação indicativa",
          "Rank",
          "Popularidade",
          "Favoritos",
          "Membros",
          "URL da imagem"
        ];

        List<TextEditingController> controllers =
        List.generate(18, (index) => TextEditingController());

        return AlertDialog(
          title: const Text('Salvar Anime'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                18,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(inputs[index]),
                      TextField(
                        controller: controllers[index],
                        decoration: const InputDecoration(
                          hintText: 'Digite aqui',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                List<String> labels =
                controllers.map((controller) => controller.text).toList();

                // Lógica para o botão "Salvar anime"
                if (labels.any((value) => value.isEmpty)) {
                  // Pelo menos um campo está vazio, mostrar mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos'),
                    ),
                  );
                } else {
                  // Todos os campos estão preenchidos, salvar anime
                  firestoreService.animeAdd(
                    labels[0],
                    labels[1],
                    labels[2],
                    labels[3],
                    labels[4],
                    labels[5],
                    labels[6],
                    labels[7],
                    labels[8],
                    labels[9],
                    labels[10],
                    labels[11],
                    labels[12],
                    labels[13],
                    labels[14],
                    labels[15],
                    labels[16],
                    labels[17],
                  );
                  Navigator.of(context).pop();
                  // Lógica para salvar as informações do anime
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Salvar anime'),
            ),
          ],
        );
      },
    );
  }
}
