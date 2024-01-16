import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:otaku_on_demand/pages/itemPage.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //const ListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Container(
            padding: const EdgeInsets.all(8.0),
            child: Text('Otaku on Demand')),
        ]
      ),
    );
  }
}
