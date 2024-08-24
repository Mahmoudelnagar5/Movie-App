import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomMovieItem extends StatelessWidget {
  final dynamic movie;

  const CustomMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/no photo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              left: 15,
            ),
            child: Text(
              movie.title?.toUpperCase() ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'muli',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
