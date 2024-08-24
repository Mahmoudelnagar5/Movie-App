import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/cubit/search_movie_state.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_service.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit() : super(SearchMovieInitial());
  List<Movie> movieList = [];
  void searchMovie(String query) async {
    emit(SearchMovieLoadingState());
    try {
      movieList = await ApiService().getMovieBySearch(query);
      print(movieList);
      emit(SearchMovieLoadedState(movieList));
    } catch (e) {
      emit(SearchMovieErrorState(e.toString()));
    }
  }
}
