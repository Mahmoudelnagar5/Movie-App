import 'package:flutter/material.dart';
import 'package:movie_app/views/widgets/custom_search_view.dart';
import 'package:movie_app/views/widgets/search_result.dart';

class Searchview extends StatelessWidget {
  const Searchview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomSearchView(),
          Expanded(
            child: SearchResults(),
          ),
        ],
      ),
    );
  }
}
