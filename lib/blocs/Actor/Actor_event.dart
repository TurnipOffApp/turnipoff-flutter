abstract class ActorEvent {}

class LoadActor extends ActorEvent {
  String id;
  LoadActor({required this.id});
}

class LoadActorCredits extends ActorEvent {
  String id;
  LoadActorCredits({required this.id});
}

class LoadingActorFailed extends ActorEvent {}
