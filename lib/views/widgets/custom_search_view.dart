import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/cubit/search_movie_cubit.dart';

class CustomSearchView extends StatelessWidget {
  const CustomSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 25),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          // alignLabelWithHint: true,
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        onChanged: (query) {
          if (query.isNotEmpty) {
            BlocProvider.of<SearchMovieCubit>(context).searchMovie(query);
          }
        },
      ),
    );
  }
}
