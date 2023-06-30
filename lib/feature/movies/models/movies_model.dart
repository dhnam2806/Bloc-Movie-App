

// import 'dart:convert';

// class MovieModels {
//   final int id;
//   final String backdropPath;
//   final String homepage;
//   final String overview;
//   final double popularity;
//   final String posterPath;
//   final String releaseDate;
//   final String title;
//   final double voteAverage;
//   final int voteCount;

//   MovieModels({
//     required this.id,
//     required this.backdropPath,
//     required this.homepage,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//     required this.voteAverage,
//     required this.voteCount,
//   });


//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'backdropPath': backdropPath,
//       'homepage': homepage,
//       'overview': overview,
//       'popularity': popularity,
//       'posterPath': posterPath,
//       'releaseDate': releaseDate,
//       'title': title,
//       'voteAverage': voteAverage,
//       'voteCount': voteCount,
//     };
//   }

//   factory MovieModels.fromJson(Map<String, dynamic> json) {
//     return MovieModels(
//       id: json['id'] ,
//       backdropPath: json['backdropPath'] ,
//       homepage: json['homepage'] ,
//       overview: json['overview'] ,
//       popularity: json['popularity'] ,
//       posterPath: json['posterPath'] ,
//       releaseDate: json['releaseDate'] ,
//       title: json['title'] ,
//       voteAverage: json['voteAverage'] ,
//       voteCount: json['voteCount'],
//     );
//   }
//   String get fullPosterPath => 'https://image.tmdb.org/t/p/w500/$posterPath';
//   // String toJson() => json.encode(toMap());

//   // factory MovieModels.fromJson(String source) => MovieModels.fromMap(json.decode(source) as Map<String, dynamic>);
// }

class MovieModels {
  late final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  MovieModels(
      {
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieModels.fromJson(Map<String, dynamic> json) {
    return MovieModels(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average']?.toDouble(),
    );
  }

  String get fullPosterPath => 'https://image.tmdb.org/t/p/w500/$posterPath';
}
