import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends ChangeNotifier {
  List<AnimeItem> animeDataList = [];
  int batchSize = 50; // Adjust the batch size as needed
  DocumentSnapshot? lastDocument;

  FirestoreService() {
    fetchData();
  }

  Future<void> fetchData() async {
    Query query = FirebaseFirestore.instance.collection('animeItem');

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.limit(batchSize).get();

    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;

      // Data firebase para o modelo animeItem
      List<AnimeItem> newItems = querySnapshot.docs
          .map((doc) => AnimeItem(
                name: doc['Name'],
                englishName: doc['English name'],
                imageURL: doc['Image URL'],
                score: doc['Score'],
                genres: doc['Genres'],
                animeid: doc['anime_id'],
                synopsis: doc['Synopsis'],
                type: doc['Type'],
                episodes: doc['Episodes'],
                aired: doc['Aired'],
                premiered: doc['Premiered'],
                source: doc['Source'],
                duration: doc['Duration'],
                rating: doc['Rating'],
                ranked: doc['Rank'],
                popularity: doc['Popularity'],
                members: doc['Members'],
                favorites: doc['Favorites'],
                scoredBy: doc['Scored By'],
                studios: doc['Studios'],
              ))
          .toList();

      animeDataList.addAll(newItems);
      notifyListeners();
    }

    // pegar banco de dados
    final CollectionReference animes =
        FirebaseFirestore.instance.collection('animeItem');

    Future<List<Map<String, dynamic>>> getDocuments() async {
      QuerySnapshot querySnapshot = await animes.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }

    // CREATE: add anime novo
    Future<void> animeAdd(
      String addname,
      String addimageURL,
      String addanimeid,
      String addenglishName,
      String addscore,
      String addgenres,
      String addsynopsis,
      String addtype,
      String addaired,
      String addepisodes,
      String addpremiered,
      String addsource,
      String addduration,
      String addrating,
      String addranked,
      String addpopularity,
      String addmembers,
      String addfavorites,
      String addwatching,
      String addcompleted,
      String addonHold,
      String adddropped,
      String addstudios,
    ) async {
      final docAnime = FirebaseFirestore.instance.collection('animeItem').doc();

      final anime = AnimeItem(
          name: addname,
          imageURL: addimageURL,
          englishName: addenglishName,
          score: addscore,
          genres: addgenres,
          animeid: addanimeid,
          synopsis: addsynopsis,
          type: addtype,
          episodes: addepisodes,
          aired: addaired,
          premiered: addpremiered,
          source: addsource,
          duration: addduration,
          rating: addrating,
          ranked: addranked,
          popularity: addpopularity,
          members: addmembers,
          favorites: addfavorites,
          scoredBy: addcompleted,
          studios: addstudios);

      final json = anime.toJson();
      await docAnime.set(json);
    }
    // READ: ler lista de animes

    // UPDATE: update um anime pelo ID
    Future<void> animeUpdate(
        String anime, String animeId, String update, String changeTo) async {
      final animeUpdate =
          FirebaseFirestore.instance.collection('animeTest').doc(animeId);
      animeUpdate.update({
        update: changeTo,
        //'Nome' = 'novo nome'
      });
    }

    // DELETE: deletar um anime pelo ID
    Future<void> animeDelete(String anime, String animeId) async {
      final animeDelete =
          FirebaseFirestore.instance.collection('animeTest').doc(animeId);
      animeDelete.delete();
    }
  }
}
