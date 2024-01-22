
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/services/firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  String name = "";

  @override
  Widget build(BuildContext context) {
    var firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Procura por nome'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: firestoreService.getDocuments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // mostrar carregando
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> documents = snapshot.data!;
                ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> documents = snapshot.data!;

                    //resultado vazio
                    if (name.isEmpty) {
                      return ListTile(
                        title: Text(
                          ('${documents[index]['Name']}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          ('${documents[index]['Score']}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                        leading: Container(
                          margin: const EdgeInsets.all(10),
                          width: 105,
                          height: 150,
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
                      );
                    }
                    if (('${documents[index]['Name']}')
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return ListTile(
                        title: Text(
                          ('${documents[index]['Name']}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          ('${documents[index]['Score']}'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                        leading: Container(
                          margin: const EdgeInsets.all(10),
                          width: 105,
                          height: 150,
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
                      );
                    }
                    return Container();},
                );
              }
              return Container();
            }));
  }
}
