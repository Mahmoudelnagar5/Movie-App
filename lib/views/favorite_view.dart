import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_app/models/movie_detail.dart';

import 'widgets/custom_movie_item.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieCubit>(context).fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    List<MovieDetail> movies =
        BlocProvider.of<MovieCubit>(context).movieDetails;
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              movies[index].delete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.red,
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  content: Text(
                    'Movie Deleted Successfully...',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            key: ValueKey(movies[index].id),
            child: CustomMovieItem(
              movie: movies[index],
            ),
          ),
        );
      },
    );
  }
}
