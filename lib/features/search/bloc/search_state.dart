part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}

final class SearchInitialState extends SearchState {}

class SearchResultsLoadingState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<ProductModel> searchedProducts;

  SearchResultsState({required this.searchedProducts});
}

class SearchNoResultsFoundState extends SearchState {}

class SearchNavigateToProductDetailsPageActionState extends SearchActionState {
  final ProductModel product;
  SearchNavigateToProductDetailsPageActionState({required this.product});
}
