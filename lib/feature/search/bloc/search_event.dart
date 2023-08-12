part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchInitialEvent extends SearchEvent {}

class SearchQueryEvent extends SearchEvent {
  final String query;

  SearchQueryEvent({
    required this.query,
  });
}

class SearchMovieClickedEvent extends SearchEvent {
  final MovieModels movie;

  SearchMovieClickedEvent({
    required this.movie,
  });
}
