import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/cubit/search_movie_cubit.dart';
import 'package:movie_app/cubits/cubit/search_movie_state.dart';
import 'package:movie_app/views/movie_details.dart';
import 'package:movie_app/views/widgets/custom_movie_item.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieCubit, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchMovieLoadedState) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'No movies found',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetails(movie: movies[index])));
                    },
                    child: CustomMovieItem(movie: movies[index])),
              );
            },
          );
        } else if (state is SearchMovieErrorState) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
