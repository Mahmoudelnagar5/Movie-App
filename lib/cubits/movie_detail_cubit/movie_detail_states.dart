import 'package:movie_app/models/movie_detail.dart';

class MovieDetailStates {}

class MovieDetailInitialState extends MovieDetailStates {}

class MovieDetailLoadingState extends MovieDetailStates {}

class MovieDetailLoadedState extends MovieDetailStates {
  MovieDetail movieDetail;

  MovieDetailLoadedState(this.movieDetail);
}

class MovieDetailErrorState extends MovieDetailStates {
  final String error;

  MovieDetailErrorState(this.error);
}
