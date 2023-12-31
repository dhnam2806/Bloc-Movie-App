import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/cast_model.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/models/video_model.dart';
import 'package:movie_app/repositories/favorite_repo.dart';
import 'package:movie_app/repositories/movie_repo.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailInitialEvent>(movieDetailInitialEvent);
    on<WatchTrailerNavigateEvent>(watchTrailerNavigateEvent);
    on<AddToFavoriteListEvent>(addToFavoriteListEvent);
  }

  FutureOr<void> movieDetailInitialEvent(
      MovieDetailInitialEvent event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoadingState());
    List<CastModels> cast = await MovieRepo().movieCast(event.movie_id.id);
    List<VideoModel> video = await MovieRepo().movieVideo(event.movie_id.id);
    emit(MovieDetailLoadingSuccessState(
      movieDetail: event.movie_id,
      cast: cast,
      video: video,
    ));
  }

  FutureOr<void> watchTrailerNavigateEvent(
      WatchTrailerNavigateEvent event, Emitter<MovieDetailState> emit) async {
    List<VideoModel> video = await MovieRepo().movieVideo(event.movie_id.id);

    emit(WatchTrailerNavigateState(videoId: video[0].key!));
  }

  FutureOr<void> addToFavoriteListEvent(AddToFavoriteListEvent event, Emitter<MovieDetailState> emit) async {
    try {
      await FavoriteRepo().switchFavoriteMovie(event.movie);
      emit(AddToFavoriteListState(movieDetail: event.movie));
    } catch (e) {
      emit(MovieDetailErrorState());
    }
  }
}
