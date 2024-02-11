import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela do Usuário',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const UserConfig(),
    );
  }
}

class UserConfig extends StatelessWidget {
  const UserConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  _mostrarPopUpMudarSenha(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.key,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mudar senha",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text("Change password",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    Spacer(),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  _mostrarPopUpSalvarAnime(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Adicione um anime",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text("Add an anime",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    Spacer(),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  _mostrarPopUpDeletar(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_forever,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Deletar Conta",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text("Delete Account",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    Spacer(),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  _mostrarPopUpSair(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sair",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Text("Log out",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarPopUpDeletar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Quer mesmo apagar sua conta?\nESSE PROCESSO É IRREVERSIVEL'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Lógica para o botão "Sim"
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        await user?.delete();
                      } catch (e) {
                        const SnackBar(
                          content: Text('Erro ao deletar conta'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 4),
                        );
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sim'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o pop-up
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Não'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarPopUpSair(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Quer mesmo sair da sua conta?'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para o botão "Sim"
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Sim'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o pop-up
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Não'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarPopUpMudarSenha(BuildContext context) {
    TextEditingController senhaController = TextEditingController();
    TextEditingController confirmarSenhaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mudar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration:
                    InputDecoration(labelText: 'Escreva sua nova senha'),
              ),
              TextField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirme sua senha'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para o botão "Salvar alterações"
                  if (senhaController.text.isEmpty ||
                      confirmarSenhaController.text.isEmpty) {
                    // Campos vazios, mostrar mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Preencha todos os campos'),
                      ),
                    );
                  } else if (senhaController.text ==
                      confirmarSenhaController.text) {
                    // Senhas são iguais, salvar alterações
                    Navigator.of(context).pop();
                    // Lógica para salvar a nova senha
                  } else {
                    // Senhas não são iguais, mostrar mensagem de erro
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('As senhas não são iguais'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Salvar alterações'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarPopUpSalvarAnime(BuildContext context) {
    List<String> labels = [
      "ID do Anime",
      "Nome do anime",
      "Nome em inglês",
      "Nota",
      "Gênero",
      "Sinopse",
      "Tipo",
      "N de Episódios",
      "Data de lançamento",
      "Data de estreia",
      "Status",
      "Estúdio",
      "Fonte",
      "Duração",
      "Classificação indicativa",
      "Rank",
      "Popularidade",
      "Favoritos",
      "Avaliado por",
      "Membros",
      "URL da imagem"
    ];

    List<TextEditingController> controllers =
        List.generate(21, (index) => TextEditingController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Salvar Anime'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                21,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(labels[index]),
                      TextField(
                        controller: controllers[index],
                        decoration: InputDecoration(
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
                // Lógica para o botão "Salvar anime"
                if (controllers.any((controller) => controller.text.isEmpty)) {
                  // Pelo menos um campo está vazio, mostrar mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Preencha todos os campos'),
                    ),
                  );
                } else {
                  // Todos os campos estão preenchidos, salvar anime
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
