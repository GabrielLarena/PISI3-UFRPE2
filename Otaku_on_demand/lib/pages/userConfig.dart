import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'package:provider/provider.dart';

class UserConfig extends StatelessWidget {
  const UserConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading indicator or placeholder can be added here
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              // Handle case where user data does not exist
              return const Center(child: Text('ERRO: Usuario não encontrado.'));
            }

            var userData = snapshot.data?.data() as Map<String, dynamic>;
            var displayName = userData['displayName'] ?? 'User';

            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Bem-vindo, $displayName',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text("Change password",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text("Add an anime",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text("Delete Account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
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
                      child: const Row(
                        children: [
                           Icon(
                            Icons.logout,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sair",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                              Text("Log out",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
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
