
abstract class MovieEvent {}

class LoadMovie extends MovieEvent {
  String id;
  LoadMovie({required this.id});
}

class LoadingMovieFailed extends MovieEvent {}
