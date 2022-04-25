import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:turnipoff/blocs/Movie/Movie_event.dart';
import 'package:turnipoff/blocs/Movie/Movie_state.dart';
import 'package:turnipoff/models/MovieData.dart';
import 'package:turnipoff/repositories/MovieRepositories.dart';

import '../../models/CreditsData.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositoryImpl _movieRepository;

  MovieBloc(this._movieRepository)
      : super(MovieLoadInProgress()) {
    on<LoadMovie>(_onLoadMovie);
    on<LoadMovieCredits>(_onLoadMovieCredits);
    on<LoadingMovieFailed>(_onLoadingInformationFailed);
  }

  void _onLoadMovie(
      LoadMovie event, Emitter<MovieState> emit) async {
    try {
      MovieData data = await _movieRepository.getMovie(event.id);
      emit((MovieLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingMovieFailed());
    }
  }

  void _onLoadingInformationFailed(
      LoadingMovieFailed event, Emitter emit) {
    emit(MovieLoadingFailure());
  }

  void _onLoadMovieCredits(LoadMovieCredits event, Emitter<MovieState> emit) async {
    try {
      CreditsData data = await _movieRepository.getMovieCredits(event.id);
      emit((MovieCreditsLoaded()).copyWith(data: data));
    } catch (_) {
      add(LoadingMovieCreditsFailed());
    }
  }
}
