
abstract class ActorEvent {}

class LoadActor extends ActorEvent {
  String id;
  LoadActor({required this.id});
}

class LoadingActorFailed extends ActorEvent {}
