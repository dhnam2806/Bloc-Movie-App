import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';

class MovieTitle extends StatelessWidget {
  final MovieModels moviesModel;

  final HomeBloc homeBloc;

  const MovieTitle(
      {super.key, required this.moviesModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://image.tmdb.org/t/p/w500/${moviesModel.posterPath}',
          height: 240,
          width: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
