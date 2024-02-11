import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/animemodel.dart';

class FavoritesProvider extends ChangeNotifier {
  List<AnimeItem> favoritesList = [];

  Future<void> getData() async {
    // Fetch user favorites from Firestore based on the user ID
    // Update favoritesList accordingly

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection(
            'users').doc(userId);

        // Get the current array of "favoritos" or initialize an empty array
        List<dynamic> favorites = (await userDocRef.get()).get('favoritos') ??
            [];

        // "favoritos" vira uma List<AnimeItem>
        favoritesList = favorites.map((item) {
          return AnimeItem(
            name: item['Name'] ?? '',
            englishName: item['English Name'] ?? '',
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
      print('Error getting favorites: $e');
    }
  }


  Future<void> addToFavorites(AnimeItem animeItem) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the current array of "favoritos" or initialize an empty array
        List<dynamic> favorites = (await userDocRef.get()).get('favoritos') ?? [];

        // Add the new AnimeItem to the "favoritos" array
        favorites.add({
          'Name': animeItem.name,
          'Image URL': animeItem.imageURL,
          'English Name': animeItem.englishName,
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

        // Update the "favoritos" array in the user's document
        await userDocRef.update({'favoritos': favorites});

        // Update favoritesList accordingly
        await getData();
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(AnimeItem animeItem) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the current array of "favoritos" or initialize an empty array
        List<dynamic> favorites = (await userDocRef.get()).get('favoritos') ?? [];

        // Remove the AnimeItem from the "favoritos" array
        favorites.removeWhere((item) => item['anime_id'] == animeItem.animeid);

        // Update the "favoritos" array in the user's document
        await userDocRef.update({'favoritos': favorites});

        // Update favoritesList accordingly
        await getData();
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }
}