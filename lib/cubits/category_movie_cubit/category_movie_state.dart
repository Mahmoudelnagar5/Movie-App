part of 'category_movie_cubit.dart';

class CategoryMovieState {}

final class CategoryMovieInitial extends CategoryMovieState {}

final class CategoryMovieLoading extends CategoryMovieState {}

final class CategoryMovieLoaded extends CategoryMovieState {
  final List<Movie> movies;
  CategoryMovieLoaded(this.movies);
}

final class CategoryMovieError extends CategoryMovieState {
  final String error;
  CategoryMovieError(this.error);
}
