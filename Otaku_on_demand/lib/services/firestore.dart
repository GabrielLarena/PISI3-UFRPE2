import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class FirestoreService {
  DocumentSnapshot? lastDocument;
  // pegar banco de dados
  final CollectionReference animes =
      FirebaseFirestore.instance.collection('animeItem');

  Stream<List<Map<String, dynamic>>> getDocumentStream(int batchSize, DocumentSnapshot? lastDocument) {
    Query query = animes
        .orderBy('Score')  // Add an ordering field
        .limit(batchSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query
        .snapshots()
        .map((querySnapshot) {
      final List<Map<String, dynamic>> result = [];
      for (final doc in querySnapshot.docs) {
        result.add({
          '_documentSnapshot': doc,
          ...doc.data() as Map<String, dynamic>,
        });
      }

      if (result.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
      }

      return result;
    });
  }



  // CREATE: add anime novo
  Future<void> animeAdd(String addname, String addimageURL) async {
    final docAnime = FirebaseFirestore.instance.collection('animes').doc();

    final anime = AnimeItem(
      name: addname,
      imageURL: addimageURL,
    );

    final json = anime.toJson();
    await docAnime.set(json);
  }
  // READ: ler lista de animes

  // UPDATE: update um anime pelo ID
  Future<void> animeUpdate(String anime,String anime_id,String update,String changeTo) async {
    final animeUpdate = FirebaseFirestore.instance.collection('animeItem').doc(
        anime_id);
    animeUpdate.update({
      update: changeTo,
      //'Nome' = 'novo nome'
    });
  }
  // DELETE: deletar um anime pelo ID
  Future<void> animeDelete(String anime,String anime_id) async {
    final animeDelete = FirebaseFirestore.instance.collection('animeItem').doc(
        anime_id);
    animeDelete.delete();
  }

}
