import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/category_movie_cubit/category_movie_cubit.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/movie_details.dart';

class BuildWidgetCategory extends StatelessWidget {
  const BuildWidgetCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return const CategoryBodyView();
  }
}

class CategoryBodyView extends StatefulWidget {
  const CategoryBodyView({super.key, this.selectedGenre = 28});
  final int selectedGenre;

  @override
  State<CategoryBodyView> createState() => _CategoryBodyViewState();
}

class _CategoryBodyViewState extends State<CategoryBodyView> {
  late int selectedGenre;

  @override
  void initState() {
    super.initState();
    print(widget.selectedGenre);
    selectedGenre = widget.selectedGenre;
    BlocProvider.of<CategoryMovieCubit>(context)
        .getMoviesByGenre(selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    List<Genre> genres = Genre.getGenres();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 28,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    print(genre.id);
                    selectedGenre = genre.id;
                  });
                  BlocProvider.of<CategoryMovieCubit>(context)
                      .getMoviesByGenre(selectedGenre);
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    border: (genre.id == selectedGenre)
                        ? Border.all(color: Colors.red)
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: (genre.id == selectedGenre)
                        ? Colors.black45
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      genre.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (genre.id == selectedGenre)
                            ? Colors.white
                            : Colors.black.withOpacity(.7),
                        fontFamily: 'muli',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<CategoryMovieCubit, CategoryMovieState>(
          builder: (context, state) {
            if (state is CategoryMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (state is CategoryMovieLoaded) {
              List<Movie> movieList = state.movies;
              return SizedBox(
                height: 350,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    Movie movie = movieList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadowColor: Colors.red,
                            elevation: 10,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 180,
                                  height: 260,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => const SizedBox(
                                width: 180,
                                height: 250,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 180,
                                height: 250,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Mahmoud Elnagar.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 180,
                          child: Text(
                            movie.title?.toUpperCase() ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (starIndex) => Icon(
                                Icons.star,
                                color: (movie.voteAverage?.toInt() ?? 0) >
                                        starIndex
                                    ? Colors.yellow
                                    : Colors.grey,
                                size: 14,
                              ),
                            ),
                            Text(
                              movie.voteAverage?.toStringAsFixed(2) ?? '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
