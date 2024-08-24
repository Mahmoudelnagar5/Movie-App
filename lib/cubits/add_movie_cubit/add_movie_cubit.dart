import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/cubits/add_movie_cubit/add_movie_states.dart';
import 'package:movie_app/models/movie_detail.dart';

class AddMovieCubit extends Cubit<AddMovieStates> {
  AddMovieCubit() : super(AddMovieInitialState());
  addMovie(MovieDetail movieDetail) async {
    emit(AddMovieLoadingState());

    try {
      await Hive.box<MovieDetail>('movieBox').add(movieDetail);
      emit(AddMovieLoadedState());
    } catch (e) {
      emit(AddMovieErrorState(e.toString()));
    }
  }
}
