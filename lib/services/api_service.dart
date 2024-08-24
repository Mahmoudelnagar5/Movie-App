import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/models/movie_images.dart';

class ApiService {
  final String baseUrl = "https://api.themoviedb.org/3/";
  final String apiKey = "4b63b255625b313fc0836904403d732d";
  Future<List<Movie>> getPopularMovie() async {
    try {
      http.Response response =
          await http.get(Uri.parse("${baseUrl}movie/popular?api_key=$apiKey"));
      'https://api.themoviedb.org/3/movie/popular?api_key=4b63b255625b313fc0836904403d732d';
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Movie> movieList = [];
      for (var item in data['results']) {
        movieList.add(Movie.fromJson(item));
      }
      return movieList;
    } catch (error, stacktracer) {
      throw Exception(
          'Exception accoured: $error with stacktrace:$stacktracer');
    }
  }

  Future<List<Movie>> getMovieBySearch(String query) async {
    try {
      http.Response response = await http.get(
          Uri.parse("${baseUrl}search/movie?api_key=$apiKey&query=$query"));
      'https://api.themoviedb.org/3/search/movie?api_key=4b63b255625b313fc0836904403d732d&query=spiderman';
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Movie> movieList = [];
      for (var item in data['results']) {
        movieList.add(Movie.fromJson(item));
      }
      return movieList;
    } catch (error, stacktracer) {
      throw Exception(
          'Exception accoured: $error with stacktrace:$stacktracer');
    }
  }

  Future<List<Movie>> getupComingMovie() async {
    try {
      http.Response response =
          await http.get(Uri.parse("${baseUrl}movie/popular?api_key=$apiKey"));
      'https://api.themoviedb.org/3/movie/now_playing?api_key=4b63b255625b313fc0836904403d732d';
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Movie> movieList = [];
      for (var item in data['results']) {
        movieList.add(Movie.fromJson(item));
      }
      return movieList;
    } catch (error, stacktracer) {
      throw Exception(
          'Exception accoured: $error with stacktrace:$stacktracer');
    }
  }

  Future<List<Movie>> getMovieByGenre(int genreId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "${baseUrl}discover/movie?api_key=$apiKey&with_genres=$genreId"));

      Map<String, dynamic> data = jsonDecode(response.body);
      List<Movie> movieList = [];
      for (var item in data['results']) {
        movieList.add(Movie.fromJson(item));
      }
      return movieList;
    } catch (error, stacktracer) {
      throw Exception(
          'Exception accoured: $error with stacktrace:$stacktracer');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final response =
          await http.get(Uri.parse('${baseUrl}movie/$movieId?api_key=$apiKey'));
      'https://api.themoviedb.org/3/movie/550?api_key=4b63b255625b313fc0836904403d732d';

      MovieDetail movieDetail = MovieDetail.fromJson(jsonDecode(response.body));

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    } catch (error, stacktracer) {
      throw Exception(
          'Exception accoured: $error with stacktrace:$stacktracer');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await http
          .get(Uri.parse('${baseUrl}movie/$id/videos?api_key=$apiKey'));
      'https://api.themoviedb.org/3/movie/550/videos?api_key=4b63b255625b313fc0836904403d732d';
      var youtubeId = jsonDecode(response.body)['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final response = await http
          .get(Uri.parse('${baseUrl}movie/$movieId/images?api_key=$apiKey'));
      'https://api.themoviedb.org/3/movie/550/images?api_key=4b63b255625b313fc0836904403d732d';

      return MovieImage.fromJson(jsonDecode(response.body));
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response = await http
          .get(Uri.parse('${baseUrl}movie/$movieId/credits?api_key=$apiKey'));
      'https://api.themoviedb.org/3/movie/550/credits?api_key=4b63b255625b313fc0836904403d732d';
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Cast> castList = [];
      for (var item in data['cast']) {
        if (item['profile_path'] != null &&
            item['name'] != null &&
            item['character'] != null) {
          castList.add(Cast.fromJson(item));
        }
      }
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
