import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movies_model.dart';
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
    final size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: movieModels
          .map((movie) => GestureDetector(
                onTap: () =>
                    homeBloc.add(HomeMovieClickedEvent(movieId: movie)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                            movie.posterPath342),
                        fit: BoxFit.cover,
                      )),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: size.height * 0.52,
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
