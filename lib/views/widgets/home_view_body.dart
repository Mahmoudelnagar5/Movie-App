import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_app/cubits/movie_cubit/movie_states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/category_view.dart';
import 'package:movie_app/views/widgets/movie_carousel.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Popular Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<MovieCubit, MovieStates>(
              builder: (context, state) {
                if (state is MovieLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieLoadedState) {
                  List<Movie> movies = state.movies;
                  return MovieCarousel(movies: movies);
                } else if (state is MovieErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const Center(
                  child: Text('Something went wrong'),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const BuildWidgetCategory(),
          ],
        ),
      ),
    );
  }
}
