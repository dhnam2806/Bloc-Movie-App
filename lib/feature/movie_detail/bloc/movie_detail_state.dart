// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailActionState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailErrorState extends MovieDetailState {}

class MovieDetailLoadingSuccessState extends MovieDetailState {
  final MovieModels movieDetail;
  final List<CastModels> cast;

  MovieDetailLoadingSuccessState({
    required this.movieDetail,
    required this.cast,
  });
}
