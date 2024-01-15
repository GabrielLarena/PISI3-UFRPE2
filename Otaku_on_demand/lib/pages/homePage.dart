import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:otaku_on_demand/services/firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
           child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: HomePageList(),
    ),));
  }
}


class HomePageList extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firestoreService = Provider.of<FirestoreService>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  "Animes favoritos",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ],
            ),
            Container(
              height: 350.0,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: firestoreService.getDocuments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> documents = snapshot.data!;

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 210,
                                      child: Text(
                                        ('${documents[index]['Name']}'),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle the onTap action here
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyHomePage(
                                                    //animeItem: AnimeItem.fromMap(documents[index]),
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        width: 210,
                                        height: 300,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                ('${documents[index]['Image URL']}')), // Replace with your image path
                                            fit: BoxFit
                                                .cover, // Choose BoxFit as per your requirement
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          });
                    }
                  }),
            ),
          ]);
  }
}
