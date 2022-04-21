import 'package:equatable/equatable.dart';
import '../../models/MoviePreviewData.dart';

enum MoviePreviewStatus { initial, success, failure }

class MoviePreviewState extends Equatable {
  const MoviePreviewState({
    this.status = MoviePreviewStatus.initial,
    this.hasReachedMax = false,
    this.page = 0,
    this.results = const <Results>[],
    this.totalPages = 0,
    this.totalResults = 0
  });

  final MoviePreviewStatus status;
  final bool hasReachedMax;
  final int page;
  final List<Results> results;
  final int totalPages;
  final int totalResults;

  MoviePreviewState copyWith({
    MoviePreviewStatus? status,
    MoviePreviewData? moviePreviewData,
    bool? hasReachedMax,
  }) {
    return MoviePreviewState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: moviePreviewData?.page ?? page,
      results: moviePreviewData?.results ?? results,
      totalPages: moviePreviewData?.totalPages ?? totalPages,
      totalResults: moviePreviewData?.totalResults ?? totalResults
    );
  }

  @override
  String toString() {
    return '''MoviePreviewState { status: $status, hasReachedMax: $hasReachedMax, posts: ${results.length} }''';
  }

  @override
  List<Object> get props => [status, results, hasReachedMax];
}
