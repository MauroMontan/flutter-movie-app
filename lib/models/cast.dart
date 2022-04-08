// To parse this JSON data, do
//
//     final castResponse = castResponseFromMap(jsonString);

import 'dart:convert';

class CastResponse {
  CastResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory CastResponse.fromJson(String str) =>
      CastResponse.fromMap(json.decode(str));

  factory CastResponse.fromMap(Map<String, dynamic> json) => CastResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  get profileImg {
    return "https://image.tmdb.org/t/p/w500$profilePath";
  }

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"] ?? "none",
        originalName: json["original_name"] ?? "none",
        popularity: json["popularity"].toDouble() ?? "none",
        profilePath:
            json["profile_path"] ?? "https://i.stack.imgur.com/GNhxO.png",
        castId: json["cast_id"] ?? 3,
        character: json["character"] ?? "none",
        creditId: json["credit_id"] ?? "none",
        order: json["order"] ?? 4,
        department: json["department"] ?? "none",
        job: json["job"] ?? "none",
      );
}
