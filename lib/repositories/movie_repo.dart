import 'dart:convert';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/video_model.dart';
import '../data/models/cast_model.dart';

class MovieRepo {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '97d39b50c99a2fd2db9f2ed346557b45';

  Future<List<MovieModels>> getMovies(String type) async {
    var client = http.Client();
    List<MovieModels> movies = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/${type}?api_key=$_apiKey'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        movies.add(MovieModels.fromJson(results[i]));
      }
      return movies;
    } catch (e) {
      throw Exception(e);
    }
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
      throw Exception(e);
    }
  }


  Future<MovieModels> fetchMovieDetails(String movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final movieData = json.decode(response.body);
        return MovieModels.fromJson(movieData);
      } else {
        throw Exception('Failed to fetch movie details');
      }
    } catch (error) {
      throw Exception('Failed to fetch movie details');
    }
  }

  Future<List<CastModels>> movieCast(int movieId) async {
    var client = http.Client();
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey'),
      );
      final List<dynamic> jsonList = json.decode(response.body)['cast'];
      return jsonList.map((json) => CastModels.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<VideoModel>> movieVideo(int movieId) async {
    var client = http.Client();
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'),
      );
      final List<dynamic> jsonList = json.decode(response.body)['results'];

      return jsonList.map((json) => VideoModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

}
