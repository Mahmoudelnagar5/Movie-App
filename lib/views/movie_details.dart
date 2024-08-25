import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/cubits/movie_detail_cubit/movie_detail_cubit.dart';
import 'package:movie_app/cubits/movie_detail_cubit/movie_detail_states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/models/movie_images.dart';
import 'package:movie_app/views/widgets/movie_detail_state.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.movie.id);
    checkIfFavorite();
  }

  void checkIfFavorite() async {
    final box = await Hive.openBox<MovieDetail>('movieBox');
    bool found = false;

    for (var movie in box.values.cast<MovieDetail>()) {
      if (movie.id == widget.movie.id) {
        found = true;
        break;
      }
    }

    setState(() {
      isFavorite = found;
    });
  }

  void toggleFavorite(MovieDetail movieDetail) async {
    final box = await Hive.openBox<MovieDetail>('movieBox');
    if (isFavorite) {
      final movieToRemove = box.values
          .cast<MovieDetail>()
          .firstWhere((movie) => movie.id == movieDetail.id);
      movieToRemove.delete();

      setState(() {
        isFavorite = false;
      });
    } else {
      await box.add(movieDetail);
      setState(() {
        isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailCubit, MovieDetailStates>(
        builder: (context, state) {
          if (state is MovieDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoadedState) {
            final movieDetail = state.movieDetail;
            return Stack(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/no photo.jpg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                toggleFavorite(movieDetail);
                              },
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500/${movieDetail.backdropPath}',
                                  height: 250,
                                  width: 180,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/no photo.jpg',
                                    height: 250,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20, top: 70),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () async {
                                final youtubeUrl = Uri.parse(
                                    'https://www.youtube.com/watch?v=${movieDetail.trailerId}');
                                if (!await launchUrl(youtubeUrl)) {
                                  throw 'Could not launch $youtubeUrl';
                                }
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    movieDetail.title, // Use dynamic title
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 214, 25, 25),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MovieDetailsState(
                                          label: 'Release date',
                                          value: movieDetail.releaseDate),
                                      MovieDetailsState(
                                          label: 'Run time',
                                          value: '${movieDetail.runtime} min'),
                                      MovieDetailsState(
                                          label: 'Rate',
                                          value: movieDetail.voteCount),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Overview'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    movieDetail.overview,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Posters'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 155,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        movieDetail.movieImage.posters!.length,
                                    itemBuilder: (context, index) {
                                      Screenshot image = movieDetail
                                          .movieImage.posters![index];
                                      return SizedBox(
                                        width: 230,
                                        child: Card(
                                          elevation: 5,
                                          shadowColor:
                                              Colors.red.withOpacity(0.8),
                                          borderOnForeground: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Casts'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemCount: movieDetail.castList.length,
                                    itemBuilder: (context, index) {
                                      final cast = movieDetail.castList[index];
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  'assets/images/no photo.jpg',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              cast.name?.toUpperCase() ?? '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: 'muli',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              cast.character?.toUpperCase() ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontFamily: 'muli',
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MovieDetailErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          } else {
            return Container(); // Empty container for unhandled states
          }
        },
      ),
    );
  }
}
