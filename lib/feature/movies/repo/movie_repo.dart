import 'dart:convert';
import 'dart:math';

import 'package:movie_app/feature/movies/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '97d39b50c99a2fd2db9f2ed346557b45';

  // Future<List<MovieModels>> fetchMovies() async {
  //   var client = http.Client();
  //   List<MovieModels> movies = [];
  //   try {
  //     final response = await client.get(
  //       Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
  //     );
  //     // List results = json.decode(response.body);

  //     // for (int i = 0; i < results.length; i++) {
  //     //   movies.add(MovieModels.fromMap(results[i]));
  //     // }
  //     // print(movies);
  //     // return movies;
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       List results = data['results'];
  //       for (int i = 0; i < results.length; i++) {
  //         movies.add(MovieModels.fromJson(results[i]));
  //       }
  //       return movies;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return [];
  // }
    Future<List<MovieModels>> fetchMovies(String data) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/${data}?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['results'];
      return jsonList.map((json) => MovieModels.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
