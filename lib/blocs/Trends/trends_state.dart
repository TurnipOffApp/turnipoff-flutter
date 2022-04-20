
import 'package:turnipoff/models/TrendsData.dart';

abstract class TrendsState {}

class TrendsLoadInProgress extends TrendsState {}

class TrendsLoaded extends TrendsState {
  TrendsData? data;

  TrendsLoaded({this.data});

  TrendsLoaded copyWith({TrendsData? data}) {
    return TrendsLoaded(data: data ?? this.data);
  }
}

class TrendsLoadingFailure extends TrendsState {}
