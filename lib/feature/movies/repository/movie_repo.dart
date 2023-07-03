import 'dart:convert';
import 'dart:math';

import 'package:movie_app/feature/movies/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '97d39b50c99a2fd2db9f2ed346557b45';

    Future<List<MovieModels>> getMovies(String type) async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/$type?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<MovieModels>> getPopularMovies() async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<MovieModels>> getDiscoverMovies() async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/discover/movie?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<MovieModels>> getNowPlayingMovies() async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<MovieModels>> getTrendingMovies() async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/trending/movie/day?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<List<MovieModels>> getMovieDetail(var movie_id) async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/${movie_id}?api_key=$_apiKey'),
      );
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      return jsonList.map((json) => MovieModels.fromJson(json)).toList();
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
