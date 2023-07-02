part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {}

class MovieDetailInitialEvent extends MovieDetailEvent {
  final MovieModels movie_id;

  MovieDetailInitialEvent({required this.movie_id});
}
