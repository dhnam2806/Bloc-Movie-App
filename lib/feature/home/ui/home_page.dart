import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/bloc/home_bloc.dart';
import 'package:movie_app/feature/home/ui/movie_title_widget.dart';

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
      listener: (context, state) {},
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
                title: Text("Movie App"),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Popular Movies",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  MovieTitle(
                      moviesModel: successState.popularMovies,
                      homeBloc: homeBloc),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Trending Movies",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  MovieTitle(
                      moviesModel: successState.trendingMovies,
                      homeBloc: homeBloc),
                ],
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
