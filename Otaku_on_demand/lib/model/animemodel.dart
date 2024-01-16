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
  final String animeid;
  final String name;
  final String englishName;
  final String imageURL;
  final String score;
  final String genres;
  final String synopsis;
  final String type;
  final String aired;
  final String episodes;
  final String premiered;
  final String source;
  final String duration;
  final String rating;
  final String ranked;
  final String popularity;
  final String members;
  final String favorites;
  final String watching;
  final String completed;
  final String onHold;
  final String dropped;

  AnimeItem({required this.name,
    required this.englishName,
    required this.imageURL,
    required this.score,
    required this.animeid,
    required this.genres,
    required this.synopsis,
    required this.type,
    required this.aired,
    required this.episodes,
    required this.premiered,
    required this.source,
    required this.duration,
    required this.rating,
    required this.ranked,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped
  });

  factory AnimeItem.fromMap(Map<String, dynamic> map) {
    return AnimeItem(
      name: map['Name'] ?? '',
      englishName: map['English Name'] ?? '',
      imageURL: map['Image URL'] ?? '',
      score: map['Scores'] ?? '',
      genres: map['Genres'] ?? '',
      animeid: map['anime_id'] ?? '',
      synopsis: map['Synopsis'] ?? '',
      type: map['Type'] ?? '',
      episodes: map['Episodes'] ?? '',
      aired: map['Aired'] ?? '',
      premiered: map['Premiered'] ?? '',
      source: map['Source'] ?? '',
      duration: map['Duration'] ?? '',
      rating: map['Rating'] ?? '',
      ranked: map['Ranked'] ?? '',
      popularity: map['Popularity'] ?? '',
      members: map['Members'] ?? '',
      favorites: map['Favorites'] ?? '',
      watching: map['Watching'] ?? '',
      completed: map['Completed'] ?? '',
      onHold: map['On-Hold'] ?? '',
      dropped: map['Dropped'] ?? '',
    );
  }

  //mapeamento Json para mandar para o databse
  //mudar ao completar a data do anime
  Map<String, dynamic> toJson() => {
    'Name': name,
    'Image URL': imageURL,
    'English Name': englishName,
    'Scores': score,
    'Genres': genres,
    'anime_id': animeid,
    'Synopsis': synopsis,
    'Type': type,
    'Episodes': episodes,
    'Aired': aired,
    'Premiered': premiered,
    'Source': source,
    'Duration': duration,
    'Rating': rating,
    'Ranked': ranked,
    'Popularity': popularity,
    'Members': members,
    'Favorites': favorites,
    'Watching': watching,
    'Completed': completed,
    'On-Hold': onHold,
    'Dropped': dropped,
      };

  //coletar informação do firebase e transformar em
  // objeto animeItem que pode ser lido
  //mudar ao completar a data do anime
  static AnimeItem fromJson(Map<String, dynamic> json) =>
      AnimeItem(
        name: json['Name'],
        englishName: json['English Name'],
        imageURL: json['Image URL'],
        score: json['Scores'],
        genres: json['Genres'],
        animeid: json['anime_id'],
        synopsis: json['Synopsis'],
        type: json['Type'],
        episodes: json['Episodes'],
        aired: json['Aired'],
        premiered: json['Premiered'],
        source: json['Source'],
        duration: json['Duration'],
        rating: json['Rating'],
        ranked: json['Ranked'],
        popularity: json['Popularity'],
        members: json['Members'],
        favorites: json['Favorites'],
        watching: json['Watching'],
        completed: json['Completed'],
        onHold: json['On-Hold'],
        dropped: json['Dropped'],
      );
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
    imageURL: 'https://cdn.myanimelist.net/images/anime/4/19644.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'SPY X FAMILY',
    imageURL:
    'https://www.crunchyroll.com/imgsrv/display/thumbnail/480x720/catalog/crunchyroll/095217fdb4f228410df09b18f151be28.jpe',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Trigun',
    imageURL: 'https://cdn.myanimelist.net/images/anime/1674/137009l.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Witch Hunter Robin',
    imageURL: 'https://cdn.myanimelist.net/images/anime/10/19969.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Bouken Ou Beet',
    imageURL: 'https://cdn.myanimelist.net/images/anime/7/21569.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Eyeshield 21',
    imageURL: 'https://cdn.myanimelist.net/images/anime/1079/133529.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Hachimitsu to Clover',
    imageURL: 'https://cdn.myanimelist.net/images/anime/1301/133577.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Hungry Heart: Wild Striker',
    imageURL: 'https://cdn.myanimelist.net/images/anime/12/49655.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Initial D Fourth Stage',
    imageURL: 'https://cdn.myanimelist.net/images/anime/9/10521.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  ),
  AnimeItem(
    name: 'Monster',
    imageURL: 'https://cdn.myanimelist.net/images/anime/10/18793.jpg',
    englishName: 'English Name',
    score: 'Scores',
    genres: 'Genres',
    animeid: 'anime_id',
    synopsis: 'Synopsis',
    type: 'Type',
    episodes: 'Episodes',
    aired: 'Aired',
    premiered: 'Premiered',
    source: 'Source',
    duration: 'Duration',
    rating: 'Rating',
    ranked: 'Ranked',
    popularity: 'Popularity',
    members: 'Members',
    favorites: 'Favorites',
    watching: 'Watching',
    completed: 'Completed',
    onHold: 'On-Hold',
    dropped: 'Dropped',
  )
];
