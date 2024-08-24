import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/movie_detail_cubit/movie_detail_states.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/services/api_service.dart';

class MovieDetailCubit extends Cubit<MovieDetailStates> {
  MovieDetailCubit() : super(MovieDetailInitialState());

  Future<void> getMovieDetail(int id) async {
    try {
      emit(MovieDetailLoadingState());
      MovieDetail movieDetail = await ApiService().getMovieDetail(id);
      emit(MovieDetailLoadedState(movieDetail));
    } catch (e) {
      emit(MovieDetailErrorState(e.toString()));
    }
  }
}
