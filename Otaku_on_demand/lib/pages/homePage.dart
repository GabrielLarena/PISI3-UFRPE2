import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/pages/listProvider.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: HomePageList(),
          ),
        ),
      ),
    );
  }
}

class HomePageList extends StatefulWidget {
  const HomePageList({super.key});

  @override
  _HomePageListState createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var firestoreService = Provider.of<FirestoreService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Animes favoritos",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: firestoreService.getDocuments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // mostrar carregando
              isLoading = true;
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              isLoading = false;
              return Text('Error: ${snapshot.error}');
            } else {
              isLoading = false;
              List<Map<String, dynamic>> documents = snapshot.data!;

              return SizedBox(
                height: 350.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210,
                            child: Text(
                              ('${documents[index]['Name']}'),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // mandar informação do anime
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                      animeItem:
                                          AnimeItem.fromMap(documents[index])),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 210,
                              height: 300,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    ('${documents[index]['Image URL']}'),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
