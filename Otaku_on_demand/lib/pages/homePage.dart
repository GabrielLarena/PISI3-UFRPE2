import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/pages/listProvider.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'package:otaku_on_demand/services/firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ListProvider(),
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
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
  @override
  _HomePageListState createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  final ScrollController _scrollController = ScrollController();
  final int initialBatchSize = 16;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  void _loadInitialData() async {
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> initialData =
    await FirestoreService().getDocumentStream(initialBatchSize, null).first;
    context.read<ListProvider>().addLoadedItems(initialData);
    setState(() {
      isLoading = false;
    });
  }

  void _onScroll() async {
    double threshold = 400.0; // Adjust the threshold as needed
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent / 2 &&
        !isLoading) {
      // Load more items when close to the end
      setState(() {
        isLoading = true;
      });
      await _loadMoreData();
      setState(() {
        isLoading = false;
      });
    }
  }

  _loadMoreData() async {
    List<Map<String, dynamic>> loadedItems =
        context.read<ListProvider>().loadedItems;

    DocumentSnapshot? lastDocument =
    loadedItems.isNotEmpty ? (loadedItems.last['_documentSnapshot'] as DocumentSnapshot) : null;

    List<Map<String, dynamic>> moreData =
    await FirestoreService().getDocumentStream(initialBatchSize, lastDocument).first;

    // Remove duplicates by checking if the document ID already exists
    moreData.removeWhere((newItem) =>
        loadedItems.any((existingItem) =>
        newItem['_documentSnapshot'].id == existingItem['_documentSnapshot'].id));

    context.read<ListProvider>().addLoadedItems(moreData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Animes favoritos",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        Container(
          height: 350.0,
          child: Consumer<ListProvider>(
            builder: (context, listProvider, child) {
              return ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: listProvider.loadedItems.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < listProvider.loadedItems.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 210,
                            child: Text(
                              ('${listProvider.loadedItems[index]['Name']}'),
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
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
                                  builder: (context) => MyHomePage(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 210,
                              height: 300,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    ('${listProvider.loadedItems[index]['Image URL']}'),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          // Loading indicator while more items are being loaded
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
