
import 'package:turnipoff/models/ActorData.dart';

abstract class ActorState {}

class ActorLoadInProgress extends ActorState {}

class ActorLoaded extends ActorState {
  ActorData? data;

  ActorLoaded({this.data});

  ActorLoaded copyWith({ActorData? data}) {
    return ActorLoaded(data: data ?? this.data);
  }
}

class ActorLoadingFailure extends ActorState {}
