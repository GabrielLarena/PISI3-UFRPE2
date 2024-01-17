import 'package:otaku_on_demand/pages/homePage.dart';
import 'package:otaku_on_demand/pages/aboutPage.dart';
import 'package:otaku_on_demand/pages/listPage.dart';
import 'package:otaku_on_demand/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/pages/userPage.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int myIndex = 0;
  List<Widget> widgetList = [
    const HomePage(),
    const ListPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 216, 216),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Handle the onTap action here
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const StartPage()));
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
                child: const Text('Otaku on Demand')),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            // botar pesquisa de anime
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
        ],
        backgroundColor: const Color(0xff9029fb),
      ),
      body: Center(
        child: widgetList[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffb58ff8),
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "feed"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "listas", ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuário",)
        ],
      ),
    );
  }
}
