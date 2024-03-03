class AnimeList {
  String title;

  AnimeList({
    required this.title,
  });
}

List<AnimeList> animeList = [
  AnimeList(title: 'Favoritos'),
  AnimeList(title: 'Assistir mais tarde'),
];

class ReviewItem {
  final String reviewID;
  final String title;
  final String review;
  final Object animeid;
  final String animescore;

  ReviewItem({
    required this.reviewID,
    required this.title,
    required this.review,
    required this.animeid,
    required this.animescore
  });

  factory ReviewItem.fromMap(Map<String, dynamic> map) {
    return ReviewItem(
      reviewID: map['reviewID'] ?? '',
      title: map['title'] ?? '',
      review: map['review'] ?? '',
      animeid: map['animeid'] ?? '',
      animescore: map['animescore'] ?? '',
    );
  }

  //mapeamento Json para mandar para o databse
  //mudar ao completar a data do anime
  Map<String, dynamic> toJson() =>
      {
        'reviewID': reviewID,
        'title': title,
        'review': review,
        'animeid': animeid,
        'animescore': animescore,
      };

  //coletar informação do firebase e transformar em
  // objeto animeItem que pode ser lido
  //mudar ao completar a data do anime
  static ReviewItem fromJson(Map<String, dynamic> json) =>
      ReviewItem(
        reviewID: json['reviewID'],
        title: json['title'],
        review: json['review'],
        animeid: json['animeid'],
        animescore: json['animescore'],
      );


}

class AnimeItem {
  final String animeid;
  final String name;
  final String englishname;
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
  final String rank;
  final String popularity;
  final String members;
  final String favorites;
  final String scoredBy;
  final String studios;

  AnimeItem({required this.name,
    required this.englishname,
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
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.scoredBy,
    required this.studios,
  });

  factory AnimeItem.fromMap(Map<String, dynamic> map) {
    return AnimeItem(
      name: map['Name'] ?? '',
      englishname: map['English name'] ?? '',
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
      rank: map['Rank'] ?? '',
      popularity: map['Popularity'] ?? '',
      members: map['Members'] ?? '',
      favorites: map['Favorites'] ?? '',
      scoredBy: map['Scored By'] ?? '',
      studios: map['Studios'] ?? '',
    );
  }

  //mapeamento Json para mandar para o databse
  //mudar ao completar a data do anime
  Map<String, dynamic> toJson() =>
      {
        'Name': name,
        'Image URL': imageURL,
        'English name': englishname,
        'Score': score,
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
        'Rank': rank,
        'Popularity': popularity,
        'Members': members,
        'Favorites': favorites,
        'Scored By': scoredBy,
        'Studios': studios,
      };

  //coletar informação do firebase e transformar em
  // objeto animeItem que pode ser lido
  //mudar ao completar a data do anime
  static AnimeItem fromJson(Map<String, dynamic> json) =>
      AnimeItem(
        name: json['Name'],
        englishname: json['English name'],
        imageURL: json['Image URL'],
        score: json['Score'],
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
        rank: json['Rank'],
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

