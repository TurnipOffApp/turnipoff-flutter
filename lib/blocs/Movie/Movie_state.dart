
import 'package:turnipoff/models/MovieData.dart';

abstract class MovieState {}

class MovieLoadInProgress extends MovieState {}

class MovieLoaded extends MovieState {
  MovieData? data;

  MovieLoaded({this.data});

  MovieLoaded copyWith({MovieData? data}) {
    return MovieLoaded(data: data ?? this.data);
  }
}

class MovieLoadingFailure extends MovieState {}
