import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/animemodel.dart';

class FavoritesProvider extends ChangeNotifier {
  List<AnimeItem> favoritesList = [];

  Future<void> getData() async {

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Referencia a coleçao usuario
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // array atual de "favoritos" ou manda uma lista vazia
        List<DocumentReference> favorites =
            (await userDocRef.get()).get('favoritos')?.cast<DocumentReference>() ?? [];

        // Coletando as referencias e adicionando na lista
        List<AnimeItem> updatedFavoritesList = [];
        for (DocumentReference animeItemRef in favorites) {
          DocumentSnapshot animeItemSnapshot;
          try {
            animeItemSnapshot = await animeItemRef.get();
          } catch (e) {
            SnackBar(
              content: Text('Erro coletando anime: $e'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            );
            continue; // Skip para o proximo
          }

          if (animeItemSnapshot.exists) {
            Map<String, dynamic> animeItemData =
                animeItemSnapshot.data() as Map<String, dynamic>;
            updatedFavoritesList.add(AnimeItem(
              name: animeItemData['Name'] ?? '',
              englishname: animeItemData['English name'] ?? '',
              imageURL: animeItemData['Image URL'] ?? '',
              score: animeItemData['Score'] ?? '',
              genres: animeItemData['Genres'] ?? '',
              animeid: animeItemData['anime_id'] ?? '',
              synopsis: animeItemData['Synopsis'] ?? '',
              type: animeItemData['Type'] ?? '',
              episodes: animeItemData['Episodes'] ?? '',
              aired: animeItemData['Aired'] ?? '',
              premiered: animeItemData['Premiered'] ?? '',
              source: animeItemData['Source'] ?? '',
              duration: animeItemData['Duration'] ?? '',
              rating: animeItemData['Rating'] ?? '',
              rank: animeItemData['Rank'] ?? '',
              popularity: animeItemData['Popularity'] ?? '',
              members: animeItemData['Members'] ?? '',
              favorites: animeItemData['Favorites'] ?? '',
              scoredBy: animeItemData['Scored By'] ?? '',
              studios: animeItemData['Studios'] ?? '',
            ));
          }
        }

        // Update da lista de favoritos
        favoritesList = updatedFavoritesList;

        // Notify listeners
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      SnackBar(
        content: Text('Erro favoritos: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
    }
  }

  Future<void> addToFavorites(String animeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Referencia do usario
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // refencia do anime
        DocumentReference animeItemRef =
        FirebaseFirestore.instance.collection('animeItem').doc(animeId);

        // adiciona anime nos 'favoritos' array do usuario
        await userDocRef.update({
          'favoritos': FieldValue.arrayUnion([animeItemRef]),
        });

        print('After update');

        await getData();
        notifyListeners();

        print('AnimeItem reference added to favorites successfully.');
      } else {
        print('User is null');
      }
    } catch (e) {
      SnackBar(
        content: Text('Erro ao adicionar: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
    }
  }

  Future<void> removeFromFavorites(String animeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Referencia da coleção users do usuario
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // referencia do documento
        DocumentReference animeItemRef =
        FirebaseFirestore.instance.collection('animeItem').doc(animeId);

        // remover o anime de 'favoritos' array do usuario
        await userDocRef.update({
          'favoritos': FieldValue.arrayRemove([animeItemRef]),
        });

        // Update favoritesList
        await getData();
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      SnackBar(
        content: Text('Erro ao deletar: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
    }
  }
}
