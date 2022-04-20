
abstract class MoviePreviewEvent {}

class LoadMoviePreview extends MoviePreviewEvent {
  PreviewType type;
  LoadMoviePreview({required this.type});
}

class LoadingMoviePreviewFailed extends MoviePreviewEvent {}

enum PreviewType {
  TRENDING,
  ACTION,
  COMEDY,
  EIGHTYS,
  NINETEES
}
