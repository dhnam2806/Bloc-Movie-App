part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

abstract class SearchActionState extends SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {}

class SearchLoadingSuccessState extends SearchState {
  final List<MovieModels> movieList;

  SearchLoadingSuccessState({
    required this.movieList,
  });

}
