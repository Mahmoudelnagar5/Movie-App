import 'package:bloc/bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_service.dart';

part 'category_movie_state.dart';

class CategoryMovieCubit extends Cubit<CategoryMovieState> {
  CategoryMovieCubit() : super(CategoryMovieInitial());

  List<Movie> movies = [];
  getMoviesByGenre(int movieID) async {
    try {
      emit(CategoryMovieLoading());
      movies = await ApiService().getMovieByGenre(movieID);

      emit(CategoryMovieLoaded(movies));
    } catch (e) {
      emit(CategoryMovieError(e.toString()));
    }
  }
}
