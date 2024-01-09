import 'dart:io';

import 'package:otaku_on_demand/pages/homePage.dart';
import 'package:otaku_on_demand/pages/aboutPage.dart';
import 'package:otaku_on_demand/pages/listPage.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:otaku_on_demand/pages/itemPage.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int myIndex = 0;
  List<Widget> widgetList = [
    HomePage(),
    ListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Handle the onTap action here
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => StartPage()));
          },
          child: Image.asset(
            'assets/images/logotipo.png',
            fit: BoxFit.contain,
            height: 32,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('Otaku on Demand')),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            // botar pesquisa de anime
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ],
        backgroundColor: Color(0xff9029fb),
      ),
      body: Center(
        child: widgetList[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff9029fb),
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(color: Colors.white),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "feed"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "listas",
          )
        ],
      ),
    );
  }
}
