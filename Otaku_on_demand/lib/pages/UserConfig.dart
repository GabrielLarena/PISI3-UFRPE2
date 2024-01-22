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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  // Lógica para o primeiro botão
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
              const Text('Quer mesmo apagar sua conta?\nESSE PROCESSO É IRREVERSIVEL'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para o botão "Sim"
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
}
