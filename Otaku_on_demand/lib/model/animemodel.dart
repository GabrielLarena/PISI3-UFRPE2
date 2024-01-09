import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AnimeList {
  String title;

  AnimeList({
    required this.title,
  });
}

List<AnimeList> animeList = [
  AnimeList(title: 'Favoritos'),
  AnimeList(title: 'Assistidos'),
  AnimeList(title: 'Ver Depois')
];

class AnimeItem {
  final String name;
  final String imageURL;

  AnimeItem({required this.name, required this.imageURL});

  factory AnimeItem.fromMap(Map<String, dynamic> map) {
    return AnimeItem(
      name: map['Name'] ?? '',
      imageURL: map['Image URL'] ?? '',
    );
  }

  //mapeamento Json para mandar para o databse
  //mudar ao completar a data do anime
  Map<String, dynamic> toJson() => {
        'Name': name,
        'Image URL': imageURL,
      };

  //coletar informação do firebase e transformar em
  // objeto animeItem que pode ser lido
  //mudar ao completar a data do anime
  static AnimeItem fromJson(Map<String, dynamic> json) =>
      AnimeItem(name: json['Name'], imageURL: json['Image URL']);
}

//coletar animes

//metodo 1-----------
//Future getAnime() async {
//await FirebaseFirestore.instance
//.collection('animeItem')
//.get()
//.then((snapshot) => snapshot.docs.forEach((element) {
//animeItem.add(element.reference.id);
//}));
//}

//metodo 2 -----------heyfluter.com
//Stream<List<AnimeItem>> readAnime() => FirebaseFirestore.instance
//.collection('animeItem')
//.snapshots()
//.map((snapshot) =>
//snapshot.docs.map((doc) => AnimeItem.fromJson(doc.data())).toList());

//metodo 3 ------------chatGPT

//test--------
List<AnimeItem> animeCheck = [
  AnimeItem(
      name: 'Cowboy Bebop',
      imageURL: 'https://cdn.myanimelist.net/images/anime/4/19644.jpg'),
  AnimeItem(
      name: 'SPY X FAMILY',
      imageURL:
          'https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/095217fdb4f228410df09b18f151be28.jpe'),
  AnimeItem(
      name: 'Trigun',
      imageURL: 'https://cdn.myanimelist.net/images/anime/1674/137009l.jpg'),
  AnimeItem(
      name: 'Witch Hunter Robin',
      imageURL: 'https://cdn.myanimelist.net/images/anime/10/19969.jpg'),
  AnimeItem(
      name: 'Bouken Ou Beet',
      imageURL: 'https://cdn.myanimelist.net/images/anime/7/21569.jpg'),
  AnimeItem(
      name: 'Eyeshield 21',
      imageURL: 'https://cdn.myanimelist.net/images/anime/1079/133529.jpg'),
  AnimeItem(
      name: 'Hachimitsu to Clover',
      imageURL: 'https://cdn.myanimelist.net/images/anime/1301/133577.jpg'),
  AnimeItem(
      name: 'Hungry Heart: Wild Striker',
      imageURL: 'https://cdn.myanimelist.net/images/anime/12/49655.jpg'),
  AnimeItem(
      name: 'Initial D Fourth Stage',
      imageURL: 'https://cdn.myanimelist.net/images/anime/9/10521.jpg'),
  AnimeItem(
      name: 'Monster',
      imageURL: 'https://cdn.myanimelist.net/images/anime/10/18793.jpg')
];
