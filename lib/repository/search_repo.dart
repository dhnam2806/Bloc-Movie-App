import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  static const _apiKey = '97d39b50c99a2fd2db9f2ed346557b45';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<MovieModels>> searchMovie(String query) async {
    var client = http.Client();
    List<MovieModels> search = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        search.add(MovieModels.fromJson(results[i]));
      }
      print('search: ' + search.toString());
      return search;
    } catch (e) {
      throw Exception(e);
    }
  }
}
