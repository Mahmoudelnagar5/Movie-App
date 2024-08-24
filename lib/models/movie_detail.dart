import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie_images.dart';
part 'movie_detail.g.dart';

@HiveType(typeId: 0)
class MovieDetail extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String backdropPath;
  @HiveField(3)
  final String budget;
  @HiveField(4)
  final String homePage;
  @HiveField(5)
  final String originalTitle;
  @HiveField(6)
  final String overview;
  @HiveField(7)
  final String releaseDate;
  @HiveField(8)
  final String runtime;
  @HiveField(9)
  final dynamic voteAverage;
  @HiveField(10)
  final String voteCount;
  late String trailerId;
  late MovieImage movieImage;
  late List<Cast> castList;

  MovieDetail({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.budget,
    required this.homePage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget']?.toString() ?? '',
      homePage: json['home_page'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime']?.toString() ?? '',
      voteAverage: json['vote_average'] ?? '',
      voteCount: json['vote_count']?.toString() ?? '',
    );
  }
}
