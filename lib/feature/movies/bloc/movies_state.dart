part of 'movies_bloc.dart';

@immutable
abstract class MoviesState {}

abstract class MoviesActionState extends MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesFetchingSuccessState extends MoviesState {}

class MoviesFetchingErrorState extends MoviesState {}
