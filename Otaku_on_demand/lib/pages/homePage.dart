import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Text("Animes favoritos",
                  style: TextStyle(color: Colors.black , fontSize:25),
                  ),
                ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                //trocar para ler favoritos
                child: Row(children:  List.generate(10,
                      (index) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Text(
                            'Nome do Anime',
                            style: TextStyle(
                                color: Colors.black , fontSize:20
                            ),
                          ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 210,
                    height: 300,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff9029fb)),
                  ),
                ],
                ),
              ),
              ),
              ),
              Row(
                children: [
                  Text("Animes Populares",
                    style: TextStyle(color: Colors.black , fontSize:25),
                  ),
                ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                //trocar para ler favoritos
                child: Row(children: List.generate(10,
                      (index) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Nome do Anime',
                                style: TextStyle(
                                    color: Colors.black , fontSize:20
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 210,
                                height: 300,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff9029fb)),
                              ),
                            ],
                          ),
                ),
                ),
              ),
        ]),
    ),
        ),
    );
  }
}
