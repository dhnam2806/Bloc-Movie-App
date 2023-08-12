part of 'favorite_bloc.dart';

@immutable
class FavoriteEvent {}

class FavoriteMoviesInitialEvent extends FavoriteEvent {
}

class FavoriteMoviesLoadedEvent extends FavoriteEvent {
  final MovieModels movie;

  FavoriteMoviesLoadedEvent({
    required this.movie,
  });
}

class FavoriteRemoveMovieEvent extends FavoriteEvent {
  final MovieModels movie;

  FavoriteRemoveMovieEvent({
    required this.movie,
  });
}

class FavoriteMovieClickedEvent extends FavoriteEvent {
  final MovieModels movie;

  FavoriteMovieClickedEvent({
    required this.movie,
  });
}
