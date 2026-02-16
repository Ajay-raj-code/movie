/// this model is used for showing searching movie result.

class SortMovieModel {
  final String title;
  final String year;
  final String imdbId;
  final String type;
  final String poster;

  SortMovieModel({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  factory SortMovieModel.fromJson({required Map<String, dynamic> json}) {
    return SortMovieModel(
      title: json["Title"],
      year: json["Year"],
      imdbId: json["imdbID"],
      type: json["Type"],
      poster: json["Poster"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "Year": year,
      "imdbID": imdbId,
      "Type": type,
      "Poster": poster,
    };
  }
}
