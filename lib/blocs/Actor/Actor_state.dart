
import 'package:turnipoff/models/ActorData.dart';
import 'package:turnipoff/models/CreditsData.dart';

abstract class ActorState {}

class ActorLoadInProgress extends ActorState {}

class ActorLoaded extends ActorState {
  ActorData? data;

  ActorLoaded({this.data});

  ActorLoaded copyWith({ActorData? data}) {
    return ActorLoaded(data: data ?? this.data);
  }
}
class ActorCreditsLoaded extends ActorState {
  CreditsData? data;

  ActorCreditsLoaded({this.data});

  ActorCreditsLoaded copyWith({CreditsData? data}) {
    return ActorCreditsLoaded(data: data ?? this.data);
  }
}

class ActorLoadingFailure extends ActorState {}
