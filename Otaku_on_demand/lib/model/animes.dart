import 'package:flutter/material.dart';

class AnimeList {
  String title;

  AnimeList({
    required this.title,});

}

List<AnimeList> animeList = [
  AnimeList(
    title: 'Favoritos'),
  AnimeList(
    title: 'Assistidos'),
  AnimeList(
    title: 'Ver Depois')
];

class AnimeItem {
  String title;
  String imageUrl;

  AnimeItem({
    required this.title,
    required this.imageUrl});
}

List<AnimeItem> animeItem = [
  AnimeItem(
    title: 'Cowboy Bebop',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/4/19644.jpg'
  ),
  AnimeItem(
    title: 'Cowboy Bebop: Tengoku no Tobira',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/1439/93480.jpg'
  ),
  AnimeItem(
    title: 'Trigun',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/1674/137009l.jpg'
  ),
  AnimeItem(
    title: 'Witch Hunter Robin',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/10/19969.jpg'
  ),
  AnimeItem(
    title: 'Bouken Ou Beet',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/7/21569.jpg'
  ),
  AnimeItem(
    title: 'Eyeshield 21',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/1079/133529.jpg'
  ),
  AnimeItem(
    title: 'Hachimitsu to Clover',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/1301/133577.jpg'
  ),
  AnimeItem(
    title: 'Hungry Heart: Wild Striker',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/12/49655.jpg'
  ),
  AnimeItem(
    title: 'Initial D Fourth Stage',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/9/10521.jpg'
  ),
  AnimeItem(
    title: 'Monster',
    imageUrl: 'https://cdn.myanimelist.net/images/anime/10/18793.jpg'
  )
];