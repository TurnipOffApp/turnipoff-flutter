
import 'package:turnipoff/models/CreditsData.dart';
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
class MovieCreditsLoaded extends MovieState {
  CreditsData? data;

  MovieCreditsLoaded({this.data});

  MovieCreditsLoaded copyWith({CreditsData? data}) {
    return MovieCreditsLoaded(data: data ?? this.data);
  }
}

class MovieLoadingFailure extends MovieState {}
