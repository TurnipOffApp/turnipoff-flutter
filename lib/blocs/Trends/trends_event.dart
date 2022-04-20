
abstract class TrendsEvent {}

class LoadTrends extends TrendsEvent {
  LoadTrends();
}

class LoadingTrendsFailed extends TrendsEvent {}
