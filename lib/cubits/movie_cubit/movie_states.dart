import 'package:movie_app/models/movie.dart';

class MovieStates {}

class MovieInitialState extends MovieStates {}

class MovieLoadingState extends MovieStates {}

class MovieLoadedState extends MovieStates {
  final List<Movie> movies;
  MovieLoadedState(this.movies);
}

class MovieErrorState extends MovieStates {
  final String error;
  MovieErrorState(this.error);
}
