part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

abstract class ExploreActionState extends ExploreState {}

final class ExploreInitial extends ExploreState {}

class ExploreNavigateToProductCategoryPageActionState
    extends ExploreActionState {
  final int categoryId;
  final String categoryName;

  ExploreNavigateToProductCategoryPageActionState({
    required this.categoryId,
    required this.categoryName,
  });
}
