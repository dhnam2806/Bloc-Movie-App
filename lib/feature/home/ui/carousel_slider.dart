import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';
import '../bloc/home_bloc.dart';

class CarouselSliderWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final List<MovieModels> movieModels;

  const CarouselSliderWidget({
    required this.homeBloc,
    required this.movieModels,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: movieModels
          .map((e) => GestureDetector(
                onTap: () => homeBloc.add(HomeMovieClickedEvent(movieId: e)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${e.fullPosterPath}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 420,
        viewportFraction: .84,
        initialPage: 0,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
