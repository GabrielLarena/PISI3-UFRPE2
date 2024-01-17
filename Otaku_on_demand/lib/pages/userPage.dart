import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

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
            child: const Text('Otaku on Demand')),
        ]
      ),
    );
  }
}
