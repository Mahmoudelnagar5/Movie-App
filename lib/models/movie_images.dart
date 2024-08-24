class MovieImage {
  List<Screenshot>? backdrops;
  List<Screenshot>? posters;

  MovieImage({this.backdrops, this.posters});
  factory MovieImage.fromJson(Map<String, dynamic> result) {
    return MovieImage(
      backdrops: (result['backdrops'] as List)
          .map((backdrop) => Screenshot.fromJson(backdrop))
          .toList(),
      posters: (result['posters'] as List)
          .map((poster) => Screenshot.fromJson(poster))
          .toList(),
    );
  }
}

class Screenshot {
  final String? aspect;
  final String? imagePath;
  final int? height;
  final int? width;
  final String? countryCode;
  final double? voteAverage;
  final int? voteCount;

  const Screenshot(
    this.aspect,
    this.imagePath,
    this.height,
    this.width,
    this.countryCode,
    this.voteAverage,
    this.voteCount,
  );

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    return Screenshot(
        json['aspect_ratio'].toString(),
        json['file_path'] as String?,
        json['height'] as int?,
        json['width'] as int?,
        json['iso_3166_1'] as String?,
        json['vote_average'] as double?,
        json['vote_count'] as int?);
  }
}
