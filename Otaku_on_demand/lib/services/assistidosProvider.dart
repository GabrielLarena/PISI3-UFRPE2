import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/animemodel.dart';

class AssistidosProvider extends ChangeNotifier {
  List<AnimeItem> favoritesList = [];

  Future<void> getData() async {
    // Fetch user assistir from Firestore based on the user ID
    // Update assistirList accordingly

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection(
            'users').doc(userId);

        // Get the current array of "assistir_depois" or initialize an empty array
        List<dynamic> assistir = (await userDocRef.get()).get('assistir_depois') ??
            [];

        // "assistir_depois" vira uma List<AnimeItem>
        favoritesList = assistir.map((item) {
          return AnimeItem(
            name: item['Name'] ?? '',
            englishname: item['English name'] ?? '',
            imageURL: item['Image URL'] ?? '',
            score: item['Score'] ?? '',
            genres: item['Genres'] ?? '',
            animeid: item['anime_id'] ?? '',
            synopsis: item['Synopsis'] ?? '',
            type: item['Type'] ?? '',
            episodes: item['Episodes'] ?? '',
            aired: item['Aired'] ?? '',
            premiered: item['Premiered'] ?? '',
            source: item['Source'] ?? '',
            duration: item['Duration'] ?? '',
            rating: item['Rating'] ?? '',
            rank: item['Rank'] ?? '',
            popularity: item['Popularity'] ?? '',
            members: item['Members'] ?? '',
            favorites: item['Favorites'] ?? '',
            scoredBy: item['Scored By'] ?? '',
            studios: item['Studios'] ?? '',
          );
        }).toList();

    // Notify listeners about the changes
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error getting assistir: $e');
    }
  }


  Future<void> addToAssistir(AnimeItem animeItem) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the current array of "'assistir_depois'" or initialize an empty array
        List<dynamic> assistir = (await userDocRef.get()).get('assistir_depois') ?? [];

        // Add the new AnimeItem to the "'assistir_depois'" array
        assistir.add({
          'Name': animeItem.name,
          'Image URL': animeItem.imageURL,
          'English name': animeItem.englishname,
          'Score': animeItem.score,
          'Genres': animeItem.genres,
          'anime_id': animeItem.animeid,
          'Synopsis': animeItem.synopsis,
          'Type': animeItem.type,
          'Episodes': animeItem.episodes,
          'Aired': animeItem.aired,
          'Premiered': animeItem.premiered,
          'Source': animeItem.source,
          'Duration': animeItem.duration,
          'Rating': animeItem.rating,
          'Rank': animeItem.rank,
          'Popularity': animeItem.popularity,
          'Members': animeItem.members,
          'Favorites': animeItem.favorites,
          'Scored By': animeItem.scoredBy,
          'Studios': animeItem.studios,
          // Include other properties based on your AnimeItem class
        });

        // Update the "assistir" array in the user's document
        await userDocRef.update({'assistir_depois': assistir});

        // Update assistirList accordingly
        await getData();
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error adding to assistir: $e');
    }
  }

  Future<void> removeFromAssistir(AnimeItem animeItem) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the current array of "assistir" or initialize an empty array
        List<dynamic> assistir = (await userDocRef.get()).get('assistir_depois') ?? [];

        // Remove the AnimeItem from the "assistir" array
        assistir.removeWhere((item) => item['anime_id'] == animeItem.animeid);

        // Update the "assistir" array in the user's document
        await userDocRef.update({'assistir_depois': assistir});

        // Update assistirList accordingly
        await getData();
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error removing from assistir: $e');
    }
  }
}