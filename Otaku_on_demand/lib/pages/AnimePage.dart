import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class MyHomePage extends StatefulWidget {
  final AnimeItem animeItem;

  const MyHomePage({required this.animeItem, Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFavorite = false;
  bool isInList = false;

  @override
  Widget build(BuildContext context) {
    //accessando a informação recebida da outra pagina
    AnimeItem animeItem = widget.animeItem;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xff9029fb),
        title: Text(
            //checa se tme nome em ingles e usa ele se tiver
            animeItem.englishName != "UNKNOWN"
                ? animeItem.englishName
                : animeItem.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coluna com a imagem e os botões
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Adicionando uma imagem
                      Image.network(
                        animeItem.imageURL,
                        width: 210,
                        height: 300,
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(
                          height: 20), // Espaçamento entre a imagem e os botões
                      // Adicionando botões roxos com ícones laranjas
                      ElevatedButton.icon(
                        onPressed: () {
                          // Lógica para o botão "Favorito"
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.deepPurple, // Cor de fundo roxa
                        ),
                        icon: Icon(
                          isFavorite ? Icons.favorite_border : Icons.favorite,
                          color: Colors.orange, // Cor do ícone laranja
                        ),
                        label: const Text(
                          'Favorito',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10), // Espaçamento entre os botões
                      ElevatedButton.icon(
                        onPressed: () {
                          // Lógica para o botão "Lista"
                          setState(() {
                            isInList = !isInList;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.deepPurple, // Cor de fundo roxa
                        ),
                        icon: Icon(
                          isInList
                              ? Icons.playlist_add_rounded
                              : Icons.playlist_add_check_rounded,
                          color: Colors.orange, // Cor do ícone laranja
                        ),
                        label: const Text(
                          'Lista   ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 20), // Espaçamento entre a imagem/botões e o texto
                  // Coluna com o texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sinopse: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          animeItem.synopsis,
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          animeItem.genres,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Espaçamento entre a seção superior e a barra roxa
              // Barra roxa dividida em três partes
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Parte da esquerda
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Episodios',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          animeItem.episodes,
                          style: TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    // Linha vertical preta
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.black,
                    ),
                    // Parte do meio
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Nota',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          animeItem.score,
                          style: TextStyle(color: Colors.white, fontSize: 8),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    // Linha vertical preta
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.black,
                    ),
                    // Parte da direita
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          animeItem.favorites,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Favoritos',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
