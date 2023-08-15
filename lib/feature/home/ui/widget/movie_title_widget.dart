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
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.36,
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
                  const EdgeInsets.only(right: 12, left: 0, top: 8, bottom: 4),
              child: Container(
                width: size.width * 0.42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        moviesModel[index].posterPath342,
                        height: size.height * 0.3,
                        width: size.width * 0.42,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      moviesModel[index].title,
                      style: TextStyle(
                        fontSize: 16,
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
