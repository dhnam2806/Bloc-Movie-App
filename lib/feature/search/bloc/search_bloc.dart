import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/repository/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
    on<SearchQueryEvent>(searchQueryEvent);
    on<SearchMovieClickedEvent>(searchMovieClickedEvent);
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) {
    emit(SearchLoadingState());
    List<MovieModels> searchRepo = [];
    emit(SearchLoadingSuccessState(movieList: searchRepo));
  }

  FutureOr<void> searchQueryEvent(
      SearchQueryEvent event, Emitter<SearchState> emit) async {
    emit(SearchingState(query: event.query));
    List<MovieModels> searchRepo = await SearchRepo().searchMovie(event.query);
    print("searchRepo: $searchRepo");
    emit(SearchLoadingSuccessState(movieList: searchRepo));
  }



  FutureOr<void> searchMovieClickedEvent(SearchMovieClickedEvent event, Emitter<SearchState> emit) {
    emit(SearchMovieClickedState(movie: event.movie));
  }
}
