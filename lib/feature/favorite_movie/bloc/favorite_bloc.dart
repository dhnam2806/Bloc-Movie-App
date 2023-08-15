import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/repositories/favorite_repo.dart';
import 'package:movie_app/repositories/movie_repo.dart';

import '../../../data/models/movies_model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteMoviesInitial()) {
    on<FavoriteMoviesInitialEvent>(favoriteMoviesInitialEvent);
    on<FavoriteRemoveMovieEvent>(favoriteRemoveMovieEvent);
    on<FavoriteMovieClickedEvent>(favoriteMovieClickedEvent);
  }

  FutureOr<void> favoriteMoviesInitialEvent(
      FavoriteMoviesInitialEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteMoviesLoading());
      List<String?> movieId = await FavoriteRepo().getFavoriteMovieIds();
      List<MovieModels> favoriteMovies = [];
      print("movieId: $movieId");
      for (var id in movieId) {
        MovieModels movie = (await MovieRepo().fetchMovieDetails(id!));
        favoriteMovies.add(movie);
      }
      emit(FavoriteMoviesLoadedState(movies: favoriteMovies));
    } catch (e) {
      emit(FavoriteMoviesErrorState(message: e.toString()));
    }
  }

  FutureOr<void> favoriteRemoveMovieEvent(
      FavoriteRemoveMovieEvent event, Emitter<FavoriteState> emit) async {
    try {
      await FavoriteRepo().removeMovieFromFavorites(event.movie.id);
      emit(FavoriteMoviesLoading());
      emit(FavoriteMovieRemoveMovieState());
      List<String?> movieId = await FavoriteRepo().getFavoriteMovieIds();
      List<MovieModels> favoriteMovies = [];
      print("movieIdRemove: $movieId");
      for (var id in movieId) {
        MovieModels movie = (await MovieRepo().fetchMovieDetails(id!));
        favoriteMovies.add(movie);
      }
      emit(FavoriteMoviesLoadedState(movies: favoriteMovies));
    } catch (e) {
      emit(FavoriteMoviesErrorState(message: e.toString()));
    }
  }

  FutureOr<void> favoriteMovieClickedEvent(FavoriteMovieClickedEvent event, Emitter<FavoriteState> emit) {
    emit(FavoriteMovieClickedState(movie: event.movie));
  }
}
