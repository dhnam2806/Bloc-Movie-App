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

  HomeLoadingSuccessState(
      {required this.popularMovies, required this.trendingMovies});
}

class HomeLoadingErrorState extends HomeState {}

class HomeMovieClickedState extends HomeActionState {
  final MovieModels movieId;

  HomeMovieClickedState({required this.movieId});
}

class NavigateToMovieDetailState extends HomeActionState {}


