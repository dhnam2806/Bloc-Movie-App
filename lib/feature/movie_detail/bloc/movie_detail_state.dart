part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailActionState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailErrorState extends MovieDetailState {}

class MovieDetailLoadingSuccessState extends MovieDetailState {
  final MovieModels movieDetail;

  MovieDetailLoadingSuccessState({required this.movieDetail});
}
