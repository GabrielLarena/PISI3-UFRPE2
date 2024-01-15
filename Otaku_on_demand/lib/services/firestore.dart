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
        .orderBy('anime_id')  // Add an ordering field
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
  Future<void> AnimeAdd(String anime) async {
    final docAnime = FirebaseFirestore.instance.collection('animes').doc();

    final anime = AnimeItem(
      name: 'Name',
      imageURL: 'ImageURL',
    );

    final json = anime.toJson();
    await docAnime.set(json);
  }
  // READ: ler lista de animes

  // UPDATE: update um anime pelo ID
  Future<void> AnimeUpdate(String anime) async {
    final animeUpdate = FirebaseFirestore.instance.collection('animeItem').doc(
        'anime_id');
    animeUpdate.update({
      'Name': 'nome novo',
    });
  }
  // DELETE: deletar um anime pelo ID
  Future<void> AnimeDelete(String anime) async {
    final animeDelete = FirebaseFirestore.instance.collection('animeItem').doc(
        'anime_id');
    animeDelete.delete();
  }

}
