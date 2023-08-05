class MovieModels {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  MovieModels({
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

  String get fullPosterPath => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500/$posterPath'
      : blankPosterPath;
  String get posterPath342 => posterPath != null
      ? 'https://image.tmdb.org/t/p/w342/$posterPath'
      : blankPosterPath;

  String blankPosterPath =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png';
}
