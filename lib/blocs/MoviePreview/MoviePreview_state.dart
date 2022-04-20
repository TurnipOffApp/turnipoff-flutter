
import 'package:turnipoff/blocs/MoviePreview/MoviePreview.dart';
import 'package:turnipoff/models/MoviePreviewData.dart';

abstract class MoviePreviewState {}

/*
class MoviePreviewInitialState extends MoviePreviewState {
  PreviewType? type;

  MoviePreviewInitialState({this.type});

  MoviePreviewInitialState copyWith({PreviewType? type}) {
    return MoviePreviewInitialState(type: type ?? this.type);
  }
}
 */

class MoviePreviewLoadInProgress extends MoviePreviewState {


}

class MoviePreviewLoaded extends MoviePreviewState {
  MoviePreviewData? data;

  MoviePreviewLoaded({this.data});

  MoviePreviewLoaded copyWith({MoviePreviewData? data}) {
    return MoviePreviewLoaded(data: data ?? this.data);
  }
}

class MoviePreviewLoadingFailure extends MoviePreviewState {}
