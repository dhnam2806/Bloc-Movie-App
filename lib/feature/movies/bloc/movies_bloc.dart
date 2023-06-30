import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';
import 'package:movie_app/feature/movies/repo/movie_repo.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesInitialEvent>(moviesInitialEvent);
  }

  FutureOr<void> moviesInitialEvent(MoviesInitialEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesFetchingSuccessState());
    // List<MovieModels> moviesPopular = await MovieRepo().fetchMovies('popular');
    // List<MovieModels> moviesTopRated = await MovieRepo().fetchMovies('top_rated');
  }
}
