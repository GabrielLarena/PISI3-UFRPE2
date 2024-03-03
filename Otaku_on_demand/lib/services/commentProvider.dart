import 'package:flutter/cupertino.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/animemodel.dart';

class ReviewService extends ChangeNotifier {
  List<ReviewItem> reviewList = [];

  Future<void> fetchReviews() async {
    // pegar data da Firebase
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('animeReview')
    //teste de limite
    //.limit(8632)
        .orderBy('reviewID', descending: true)
        .get();

    // transformando data em modelo animeItem
    reviewList = querySnapshot.docs
        .map((doc) => ReviewItem(
      reviewID: doc['reviewID'],
      title: doc['title'],
      review: doc['review'],
      animeid: doc['animeid'],
      animescore: doc['animescore'],
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
  Future<void> reviewAdd(
      String addtitle,
      String addreview,
      String addanimeid,
      String addscore,
      ) async {
    //ultimo ID
    final lastIDDocument = await FirebaseFirestore.instance
        .collection('lastItemID')
        .doc('Last ID')
        .get();
    int lastID = (lastIDDocument.data() ?? {})['LastReviewID'] ?? 0;

    final lastid = lastID.toString();

    final docReview =
    FirebaseFirestore.instance.collection('animeReview').doc(lastid);

    final review = ReviewItem(
        reviewID: lastid,
        title: addtitle,
        review: addreview,
        animeid: addanimeid,
        animescore: addscore
    );

    final json = review.toJson();
    await docReview.set(json);

    //aumentando o ultimo ID
    await FirebaseFirestore.instance
        .collection('lastItemID')
        .doc('Last ID')
        .update({
      'LastReviewID': lastID + 1,
    });
    print('part1');
  }

  // READ: ler lista de animes

  // UPDATE: update um anime pelo ID
  Future<void> updateReview(ReviewItem updatedReview) async {
    try {
      // Reference to the document in the 'animeItem' collection
      DocumentReference reviewDocRef =
      FirebaseFirestore.instance.collection('animeReview').doc(updatedReview.reviewID);

      // Update the document with the new values
      await reviewDocRef.update({
        'reviewID': updatedReview.reviewID,
        'title': updatedReview.title,
        'review': updatedReview.review,
        'animeid': updatedReview.animeid,
        'animescore': updatedReview.animescore,
      });

      // Notify listeners about the changes
      notifyListeners();
    } catch (e) {
      print('Error updating review: $e');
    }
  }

  // DELETE: deletar um anime pelo ID
  Future<void> reviewDelete(String anime, String reviewID) async {
    final animeDelete =
    FirebaseFirestore.instance.collection('animeReview').doc(reviewID);
    animeDelete.delete();
  }
}
