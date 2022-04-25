import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:turnipoff/repositories/MoviePreviewRepositories.dart';

import '../../models/MoviePreviewData.dart';
import 'MoviePreview_event.dart';
import 'MoviePreview_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MoviePreviewBloc extends Bloc<MoviePreviewEvent, MoviePreviewState> {
  MoviePreviewBloc() : super(const MoviePreviewState()) {
    on<MoviePreviewFetched>(
      _onMoviePreviewFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onMoviePreviewFetched(
      MoviePreviewFetched event, Emitter<MoviePreviewState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MoviePreviewStatus.initial) {
        final posts = await _fetchMovies(event.type);
        return emit(state.copyWith(
          status: MoviePreviewStatus.success,
          hasReachedMax: false,
          moviePreviewData: posts,
        ));
      }
      final movies = await _fetchMovies(event.type, state.page + 1);
      movies.results?.isEmpty ?? true
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MoviePreviewStatus.success,
                moviePreviewData: MoviePreviewData(
                    page: movies.page,
                    results:
                        state.results.followedBy(movies.results ?? []).toList(),
                    totalPages: movies.totalPages,
                    totalResults: movies.totalResults),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MoviePreviewStatus.failure));
    }
  }

  Future<MoviePreviewData> _fetchMovies(PreviewType type,
      [int page = 1]) async {
    var repo = MoviePreviewRepositoryImpl();
    switch (type) {
      case PreviewType.CUSTOM_TRENDS:
        return repo.getCustomTrends();
      case PreviewType.ACTION:
        return repo.getActionPreview(page);
      case PreviewType.COMEDY:
        return repo.getComedyPreview(page);
      case PreviewType.EIGHTYS:
        return repo.getEightysPreview(page);
      case PreviewType.NINETEES:
        return repo.getNineteensPreview(page);
      default:
        break;
    }
    throw Exception('error fetching posts');
  }
}
