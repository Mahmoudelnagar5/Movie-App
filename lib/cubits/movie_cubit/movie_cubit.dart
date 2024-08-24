import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/cubits/movie_cubit/movie_states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/services/api_service.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitialState());

  List<Movie> popularMovies = [];
  void getPopularMovies() async {
    try {
      emit(MovieLoadingState());
      popularMovies = await ApiService().getPopularMovie();
      emit(MovieLoadedState(popularMovies));
    } catch (e) {
      emit(MovieErrorState(e.toString()));
    }
  }

  List<MovieDetail> movieDetails = [];
  fetchAllMovies() async {
    var moviesBox = Hive.box<MovieDetail>('movieBox');
    movieDetails = moviesBox.values.toList();
    // print(movieDetails.length);
  }
}
