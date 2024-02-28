part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class ExploreInitialEvent extends ExploreEvent {}

class ExploreNavigateToProductCategorisedEvent extends ExploreEvent {
  final int categoryId;
  final String categoryName;
  ExploreNavigateToProductCategorisedEvent(
      {required this.categoryName, required this.categoryId});
}

class ExploreNavigateToSearchPageEvent extends ExploreEvent {
}
