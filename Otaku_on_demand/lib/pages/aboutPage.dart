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
                  Text("texto sobre o aplicativo")
                ])),
          ),
          padding: EdgeInsets.all(50),
        ));
  }
}
