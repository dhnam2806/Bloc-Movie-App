import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/feature/search/models/search_movie_models.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  static const _apiKey = '97d39b50c99a2fd2db9f2ed346557b45';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Search>> searchMovie(String query) async {
    var client = http.Client();
    List<Search> search = [];
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/search/multi?api_key=$_apiKey&query=$query'),
      );
      var data = json.decode(response.body);
      List results = data['results'];
      for (int i = 0; i < results.length; i++) {
        search.add(Search.fromJson(results[i]));
      }
      debugPrint('search' + search.toString());
      return search;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
