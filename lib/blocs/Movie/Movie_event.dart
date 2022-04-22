
abstract class MovieEvent {}

class LoadMovie extends MovieEvent {
  String id;
  LoadMovie({required this.id});
}
class LoadMovieCredits extends MovieEvent {
  String id;
  LoadMovieCredits({required this.id});
}

class LoadingMovieFailed extends MovieEvent {}

class LoadingMovieCreditsFailed extends MovieEvent {}
