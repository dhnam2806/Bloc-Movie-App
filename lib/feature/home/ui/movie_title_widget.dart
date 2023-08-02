import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';
import 'package:movie_app/data/models/movies_model.dart';

class MovieTitle extends StatelessWidget {
  final List<MovieModels> moviesModel;

  final Bloc homeBloc;

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
              padding:
                  const EdgeInsets.only(right: 12, left: 0, top: 8, bottom: 8),
              child: Container(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${moviesModel[index].posterPath}',
                        height: 240,
                        width: 168,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      moviesModel[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
