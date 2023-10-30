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
          backgroundColor: Colors.white,
        ),
        body: Padding(
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logotipo.jpg",
                            ),
                            fit: BoxFit.fill)),
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
                        color: Color(0xff29af6f),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Divider(height: 30),
                  Text(
                      "O agravamento da saúde e qualidade de vida e a diminuição do tempo disponível para cuidar de si, são fatores que têm aumentado consideravelmente na rotina da atual sociedade. Ao avaliar a situação, percebe-se que os hábitos alimentares inadequados influenciam e são influenciados fortemente nestas condições. Devido a isso, com o passar dos anos, os humanos cada vez mais incorporam a tecnologia em seu dia a dia,- utilizando o smartphone e suas aplicações como meio principal para obtenção de informações, por meio de sistemas de clusterização. Pensando nisso, este projeto utilizará uma base de dados pública, obtida pelo site Kaggle, que agrega mais de 500 mil receitas por meio das quais serão realizadas análises e a criação de um modelo de clusterização, visando agrupar dados em determinados conjuntos distintos entre si. Por meio disso, a solução prevê, por fim, um aplicativo que categoriza as receitas de acordo com a com opção e desejo de cada usuário para que o mesmo possa manter uma rotina saudável, com refeições práticas e qualidade de vida.")
                ])),
          ),
          padding: EdgeInsets.all(50),
        ));
  }
}
