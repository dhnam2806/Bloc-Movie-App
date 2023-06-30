import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/feature/movies/repo/movie_repo.dart';

import '../../movies/models/movies_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<MovieModels> moviesPopular = await MovieRepo().fetchMovies("popular");

    emit(HomeLoadingSuccessState(moviesModel: moviesPopular));
  }
}
