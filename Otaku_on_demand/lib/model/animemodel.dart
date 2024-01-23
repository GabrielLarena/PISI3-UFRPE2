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
  final String scoredBy;
  final String studios;

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
    required this.scoredBy,
    required this.studios,
  });

  factory AnimeItem.fromMap(Map<String, dynamic> map) {
    return AnimeItem(
      name: map['Name'] ?? '',
      englishName: map['English name'] ?? '',
      imageURL: map['Image URL'] ?? '',
      score: map['Score'] ?? '',
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
      ranked: map['Rank'] ?? '',
      popularity: map['Popularity'] ?? '',
      members: map['Members'] ?? '',
      favorites: map['Favorites'] ?? '',
      scoredBy: map['Scored By'] ?? '',
      studios: map['Studios'] ?? '',
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
    'Scored By': scoredBy,
    'Studios' : studios,
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
        scoredBy: json['Completed'],
        studios: json['Studios'],
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

