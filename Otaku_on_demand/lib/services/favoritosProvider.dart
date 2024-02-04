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
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // Get the current array of "favoritos" or initialize an empty array
        List<DocumentReference> favorites =
            (await userDocRef.get()).get('favoritos')?.cast<DocumentReference>() ?? [];

        // Fetch each referenced animeItem and update the favoritesList
        List<AnimeItem> updatedFavoritesList = [];
        for (DocumentReference animeItemRef in favorites) {
          DocumentSnapshot animeItemSnapshot;
          try {
            animeItemSnapshot = await animeItemRef.get();
          } catch (e) {
            print('Error fetching animeItem: $e');
            continue; // Skip to the next iteration
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

        // Update favoritesList accordingly
        favoritesList = updatedFavoritesList;

        // Notify listeners about the changes
        notifyListeners();
      } else {
        print('User is null');
      }
    } catch (e) {
      print('Error getting favorites: $e');
    }
  }

  Future<void> addToFavorites(String animeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user document
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        print('user: $userDocRef');

        // Create a new document reference for animeItem
        DocumentReference animeItemRef =
        FirebaseFirestore.instance.collection('animeTest').doc(animeId);

        //test
        print('AnimeItem Reference: $animeItemRef');

        print('Before update');

        // Add the animeItem reference to the 'favoritos' array in the user document
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
      print('Error adding AnimeItem reference to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String animeId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's document in the "users" collection
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

        // Create a new document reference for animeItem
        DocumentReference animeItemRef =
        FirebaseFirestore.instance.collection('animeTest').doc(animeId);

        // Remove the animeItem reference from the 'favoritos' array in the user document
        await userDocRef.update({
          'favoritos': FieldValue.arrayRemove([animeItemRef]),
        });

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
