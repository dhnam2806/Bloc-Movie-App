part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeActionState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<MovieModels> popularMovies;
  final List<MovieModels> trendingMovies;
  final List<MovieModels> nowPlayingMovies;
  final List<MovieModels> topRatedMovies;

  HomeLoadingSuccessState(
      {required this.popularMovies,
      required this.trendingMovies,
      required this.nowPlayingMovies,
      required this.topRatedMovies});
}

class HomeLoadingErrorState extends HomeState {}

class HomeMovieClickedState extends HomeActionState {
  final MovieModels movie;

  HomeMovieClickedState({required this.movie});
}

