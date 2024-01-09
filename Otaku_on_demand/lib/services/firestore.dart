import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';

class FirestoreService {
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
  Future<void> Anime(String anime) async {
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

  // DELETE: deletar um anime pelo ID
}
