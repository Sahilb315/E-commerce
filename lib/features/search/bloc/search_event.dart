part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchInitalEvent extends SearchEvent {}

class SearchTextFieldSubmittedEvent extends SearchEvent {
  final List<ProductModel> searchedProducts;

  SearchTextFieldSubmittedEvent({required this.searchedProducts});
}

class SearchNavigateToProductDetailsPageEvent extends SearchEvent {
  final ProductModel product;
  SearchNavigateToProductDetailsPageEvent({required this.product});
}
