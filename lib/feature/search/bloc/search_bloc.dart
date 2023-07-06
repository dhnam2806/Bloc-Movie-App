import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/repository/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
  }

  FutureOr<void> searchInitialEvent(SearchInitialEvent event, Emitter<SearchState> emit)async{
    emit(SearchLoadingState());
    List<MovieModels> movieList = await SearchRepo().searchMovie(event.query);
    emit(SearchLoadingSuccessState( movieList: movieList,));
  }
}
