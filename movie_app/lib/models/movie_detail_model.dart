import 'dart:convert';

MovieDetailResponse movieDetailResponseFromJson(String str) =>
    MovieDetailResponse.fromJson(json.decode(str));

String movieDetailResponseToJson(MovieDetailResponse data) =>
    json.encode(data.toJson());

class MovieDetailResponse {
  MovieDetailResponse({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  int budget;
  List<Genre> genres;
  String? homepage;
  int id;
  String originalLanguage;
  String originalTitle;
  String? overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  int revenue;
  String status;
  String tagline;
  String title;
  double voteAverage;
  int voteCount;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "status": status,
        "tagline": tagline,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
