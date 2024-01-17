import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0xff9029fb),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logotipo.png',
                        fit: BoxFit.contain,
                        height: 96,
                      ),
                      const Text(
                    "Otaku on demand",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Versão 1.0',
                      style: TextStyle(
                        color: Color(0xff156f43),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  const Divider(height: 30),
                  const Text("Nosso App:\n\nMais de 100 milhões de entusiastas de anime e mangá de todo o mundo procuram entretenimento todos os dias, e aqui, no OtakuOnDemand eles podem se conectar com sua paixão por histórias incríveis. O aplicativo é gratuito e acessível a fãs de anime em todos os cantos do globo.\n\nNossa missão:\n\nHoje, o OtakuOnDemand propõe: listar seus animes favoritos, classificá-los e descobrir novos títulos. Nosso compromisso é permitir que os fãs de anime possam explorar seu amor por essa forma de arte única.\n\nNossa equipe:\n\nO projeto foi criado por um grupo de entusiastas apaixonados por animação. Embora façamos parte de uma comunidade maior de amantes de anime,  operamos de forma independente, focados em oferecer a melhor experiência para nossos usuários. Estamos dedicados a manter viva a paixão pela cultura asiática, e estamos ansiosos para continuar essa jornada. ")
                ])),
          ),
        ));
  }
}
