import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';
import 'package:movie_app/feature/home/ui/movie_title_widget.dart';
import 'package:movie_app/feature/movie_detail/ui/movie_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is HomeMovieClickedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: state.movieId)));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );

          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: RichText(
                  text: TextSpan(
                    text: "Movie",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    children: [
                      TextSpan(
                        text: "App",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        items: successState.popularMovies
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
                          height: 400,
                          // aspectRatio: 14 / 9,
                          viewportFraction: .8,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {},
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Popular Movies",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      MovieTitle(
                          moviesModel: successState.popularMovies,
                          homeBloc: homeBloc),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Trending Movies",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      MovieTitle(
                          moviesModel: successState.trendingMovies,
                          homeBloc: homeBloc),
                    ],
                  ),
                ),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
