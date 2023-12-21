import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Define a cor principal como roxo
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFavorite = false;
  bool isInList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9029fb),
        title: const Text('SPY x FAMILY'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      'https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/095217fdb4f228410df09b18f151be28.jpe',
                      width: 200,
                      height: 200,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 20), // Espaçamento entre a imagem e os botões
                    // Adicionando botões roxos com ícones laranjas
                    ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para o botão "Favorito"
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple, // Cor de fundo roxa
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
                        backgroundColor: Colors.deepPurple, // Cor de fundo roxa
                      ),
                      icon: Icon(
                        isInList ? Icons.playlist_add_rounded : Icons.playlist_add_check_rounded,
                        color: Colors.orange, // Cor do ícone laranja
                      ),
                      label: const Text(
                        'Lista      ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20), // Espaçamento entre a imagem/botões e o texto
                // Coluna com o texto
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sinopse',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Há décadas, as nações de Ostania e Westalis promovem uma guerra fria sem fim. Para investigar os movimentos do presidente de um importante partido político, Westalis mobiliza Twilight, seu melhor agente, a montar uma família falsa e se infiltrar nos eventos sociais promovidos pela escola do filho do político. Mas por um acaso do destino, Twilight acaba adotando Anya, uma jovem com poderes telepáticos, e se "casando" com Yor, uma assassina profissional! Sem saberem das identidades uns dos outros, este trio incomum vai embarcar em aventuras cheias de surpresas para garantir a paz mundial.',
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gêneros: Ação, Comédia, Aventura',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaçamento entre a seção superior e a barra roxa
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
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Autor',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Endou Tatsuya',
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
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Nota',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '7.7',
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
                        '2233',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
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
    );
  }
}
