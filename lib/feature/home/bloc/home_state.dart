part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeActionState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<MovieModels> moviesModel;

  HomeLoadingSuccessState({required this.moviesModel});
}

class HomeLoadingErrorState extends HomeState {}
