// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {}

class MovieDetailInitialEvent extends MovieDetailEvent {
  final MovieModels movie_id;

  MovieDetailInitialEvent({
    required this.movie_id,
  });
}

class WatchTrailerNavigateEvent extends MovieDetailEvent {
  final MovieModels movie_id;

  WatchTrailerNavigateEvent({
    required this.movie_id,
  });
}

class AddToFavoriteListEvent extends MovieDetailEvent {
  final MovieModels movie;

  AddToFavoriteListEvent({
    required this.movie,
  });
}

class RemoveFromFavoriteListEvent extends MovieDetailEvent {
  final MovieModels movie;

  RemoveFromFavoriteListEvent({
    required this.movie,
  });
}



