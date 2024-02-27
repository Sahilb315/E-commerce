part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteEvent {}

class FavouritesFetchEvent extends FavouriteEvent {}

class FavouriteNavigateToProductDetailsPageEvent extends FavouriteEvent {
  final ProductModel productModel;

  FavouriteNavigateToProductDetailsPageEvent({required this.productModel});
}

class FavouriteProductRemovedEvent extends FavouriteEvent {
  final ProductModel productModel;

  FavouriteProductRemovedEvent({required this.productModel});
}
