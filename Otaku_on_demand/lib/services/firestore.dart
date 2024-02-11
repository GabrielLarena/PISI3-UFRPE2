import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService extends ChangeNotifier {
  List<AnimeItem> animeDataList = [];

  Future<void> fetchData() async {
    // pegar data da Firebase
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('animeItem')
        //teste de limite
        //.limit(8632)
        .orderBy('Score', descending: true)
        .get();

    // transformando data em modelo animeItem
    animeDataList = querySnapshot.docs
        .map((doc) => AnimeItem(
              name: doc['Name'],
              englishname: doc['English name'],
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
              rank: doc['Rank'],
              popularity: doc['Popularity'],
              members: doc['Members'],
              favorites: doc['Favorites'],
              scoredBy: doc['Scored By'],
              studios: doc['Studios'],
            ))
        .toList();

    notifyListeners();
  }

  // pegar banco de dados
  //final CollectionReference animes =
  //FirebaseFirestore.instance.collection('animeItem');

  // Future<List<Map<String, dynamic>>> getDocuments() async {
  //QuerySnapshot querySnapshot = await animes.get();
  //return querySnapshot.docs
  //.map((doc) => doc.data() as Map<String, dynamic>)
  //.toList();
  //}

  // CREATE: add anime novo
  Future<void> animeAdd(
    String addname,
    String addenglishname,
    String addscore,
    String addgenres,
    String addsynopsis,
    String addtype,
    String addepisodes,
    String addpremiered,
    String addaired,
    String addstudios,
    String addsource,
    String addduration,
    String addrating,
    String addrank,
    String addpopularity,
    String addfavorites,
    String addmembers,
    String addimageURL,
  ) async {
    //ultimo ID
    final lastIDDocument = await FirebaseFirestore.instance
        .collection('lastItemID')
        .doc('Last ID')
        .get();
    int lastID = (lastIDDocument.data() ?? {})['LastID'] ?? 0;

    final lastid = lastID.toString();

    final docAnime =
        FirebaseFirestore.instance.collection('animeItem').doc(lastid);

    final anime = AnimeItem(
        name: addname,
        imageURL: addimageURL,
        englishname: addenglishname,
        score: addscore,
        genres: addgenres,
        animeid: lastid,
        synopsis: addsynopsis,
        type: addtype,
        episodes: addepisodes,
        aired: addaired,
        premiered: addpremiered,
        source: addsource,
        duration: addduration,
        rating: addrating,
        rank: addrank,
        popularity: addpopularity,
        members: addmembers,
        favorites: addfavorites,
        scoredBy: '1',
        studios: addstudios);

    final json = anime.toJson();
    await docAnime.set(json);

    //aumentando o ultimo ID
    await FirebaseFirestore.instance
        .collection('lastItemID')
        .doc('Last ID')
        .update({
      'LastID': lastID + 1,
    });
  }

  // READ: ler lista de animes

  // UPDATE: update um anime pelo ID
  Future<void> updateAnime(AnimeItem updatedAnime) async {
    try {
      // Reference to the document in the 'animeItem' collection
      DocumentReference animeDocRef =
      FirebaseFirestore.instance.collection('animeItem').doc(updatedAnime.animeid);

      // Update the document with the new values
      await animeDocRef.update({
        'Name': updatedAnime.name,
        'English name': updatedAnime.englishname,
        'Image URL': updatedAnime.imageURL,
        'Score': updatedAnime.score,
        'Genres': updatedAnime.genres,
        'Type': updatedAnime.type,
        'Episodes': updatedAnime.episodes,
        'Aired': updatedAnime.aired,
        'Premiered': updatedAnime.premiered,
        'Source': updatedAnime.source,
        'Duration': updatedAnime.duration,
        'Rating': updatedAnime.rating,
        'Rank': updatedAnime.rank,
        'Popularity': updatedAnime.popularity,
        'Members': updatedAnime.members,
        'Favorites': updatedAnime.favorites,
        'Scored By': updatedAnime.scoredBy,
        'Studios': updatedAnime.studios,
      });

      // Notify listeners about the changes
      notifyListeners();
    } catch (e) {
      print('Error updating anime: $e');
    }
  }

  // DELETE: deletar um anime pelo ID
  Future<void> animeDelete(String anime, String animeId) async {
    final animeDelete =
        FirebaseFirestore.instance.collection('animeItem').doc(animeId);
    animeDelete.delete();
  }
}
