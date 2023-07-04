import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/feature/movies/models/cast_model.dart';
import 'package:movie_app/feature/movies/models/movies_model.dart';
import 'package:movie_app/feature/movies/repository/movie_repo.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailInitialEvent>(movieDetailInitialEvent);
  }

  FutureOr<void> movieDetailInitialEvent(
      MovieDetailInitialEvent event, Emitter<MovieDetailState> emit) async{
    emit(MovieDetailLoadingState());
    List<CastModels> cast = await MovieRepo().movieCast(event.movie_id.id);
    emit(MovieDetailLoadingSuccessState(movieDetail: event.movie_id, cast: cast,));
  }
}
