part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchInitialEvent extends SearchEvent {
  final String query;

  SearchInitialEvent({
    required this.query,
  });
}

class SearchQueryEvent extends SearchEvent {
  final String query;

  SearchQueryEvent({
    required this.query,
  });
}
