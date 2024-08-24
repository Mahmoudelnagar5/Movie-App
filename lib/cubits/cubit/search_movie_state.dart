import 'package:movie_app/models/movie.dart';

class SearchMovieState {}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoadingState extends SearchMovieState {}

final class SearchMovieLoadedState extends SearchMovieState {
  final List<Movie> movies;

  SearchMovieLoadedState(this.movies);
}

final class SearchMovieErrorState extends SearchMovieState {
  final String error;

  SearchMovieErrorState(this.error);
}
