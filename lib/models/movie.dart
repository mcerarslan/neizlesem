
class Movie{
  String? title;
  String? backDropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;

  Movie(
      { this.title,
        this.backDropPath,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.voteAverage,

      });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"],
        backDropPath: json["backdrop_path"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"],
    );
  }
}