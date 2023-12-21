import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff9029fb),
        ),
        body: Padding(
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
                      Text(
                    "Otaku on demand",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Versão 1.0',
                      style: const TextStyle(
                        color: Color(0xff156f43),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Divider(height: 30),
                  Text("Nosso App:\n\nMais de 100 milhões de entusiastas de anime e mangá de todo o mundo procuram entretenimento todos os dias, e aqui, no OtakuOnDemand eles podem se conectar com sua paixão por histórias incríveis. O aplicativo é gratuito e acessível a fãs de anime em todos os cantos do globo.\n\nNossa missão:\n\nHoje, o OtakuOnDemand propõe: listar seus animes favoritos, classificá-los e descobrir novos títulos. Nosso compromisso é permitir que os fãs de anime possam explorar seu amor por essa forma de arte única.\n\nNossa equipe:\n\nO projeto foi criado por um grupo de entusiastas apaixonados por animação. Embora façamos parte de uma comunidade maior de amantes de anime,  operamos de forma independente, focados em oferecer a melhor experiência para nossos usuários. Estamos dedicados a manter viva a paixão pela cultura asiática, e estamos ansiosos para continuar essa jornada. ")
                ])),
          ),
          padding: EdgeInsets.all(50),
        ));
  }
}
