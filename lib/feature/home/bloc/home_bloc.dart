import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/feature/movies/repository/movie_repo.dart';

import '../../movies/models/movies_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeMovieClickedEvent>(homeMovieClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<MovieModels> moviesPopular = await MovieRepo().getMovies("popular");
    List<MovieModels> nowPlayingMovies =
        await MovieRepo().getMovies("now_playing");
    List<MovieModels> moviesTrending = await MovieRepo().getTrendingMovies();
    List<MovieModels> discoverMovies = await MovieRepo().getDiscoverMovies();
    List<MovieModels> moviesTopRated = await MovieRepo().getMovies("top_rated");

    emit(HomeLoadingSuccessState(
      popularMovies: moviesPopular,
      trendingMovies: moviesTrending,
      discoverMovies: discoverMovies,
      nowPlayingMovies: nowPlayingMovies,
      topRatedMovies: moviesTopRated,
    ));
  }

  FutureOr<void> homeMovieClickedEvent(
      HomeMovieClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeMovieClickedState(movieId: event.movieId));
    // emit(NavigateToMovieDetailState());
  }
}
