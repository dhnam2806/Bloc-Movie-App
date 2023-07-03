import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';

class MovieTitle extends StatelessWidget {
  final List<MovieModels> moviesModel;

  final HomeBloc homeBloc;

  const MovieTitle(
      {super.key, required this.moviesModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moviesModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              homeBloc.add(HomeMovieClickedEvent(movieId: moviesModel[index]));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${moviesModel[index].posterPath}',
                    height: 240,
                    width: 168,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
