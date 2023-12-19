import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animes.dart';

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
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Text("Animes favoritos",
                      style: TextStyle(color: Colors.black , fontSize:25),
                    ),
                  ],
                ),

                Container(
                  height: 350.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: animeItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                animeItem[index].title,
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
                                  image: DecorationImage(
                                    image: NetworkImage(animeItem[index].imageUrl), // Replace with your image path
                                    fit: BoxFit.cover, // Choose BoxFit as per your requirement
                                  ),
                                ),),
                            ],
                          )
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Text("Animes Populares",
                      style: TextStyle(color: Colors.black , fontSize:25),
                    ),
                  ],
                ),

                Container(
                  height: 350.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: animeItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animeItem[index].title,
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
                                image: DecorationImage(
                                  image: NetworkImage(animeItem[index].imageUrl), // Replace with your image path
                                  fit: BoxFit.cover, // Choose BoxFit as per your requirement
                                ),
                            ),),
                          ],
                        )
                      );
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}