part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}

class ProductDetailInitialEvent extends ProductDetailEvent {}

class ProductDetailProductAddedToFavouriteEvent extends ProductDetailEvent {
  final ProductModel productModel;

  ProductDetailProductAddedToFavouriteEvent({required this.productModel});
}

class ProductDetailProductRemovedFromFavouriteEvent extends ProductDetailEvent {
  final ProductModel productModel;

  ProductDetailProductRemovedFromFavouriteEvent({required this.productModel});
}

class ProductDetailProductAddToCartEvent extends ProductDetailEvent {
  final CartModel productModel;

  ProductDetailProductAddToCartEvent({required this.productModel});
}

class ProductDetailNavigateToCartPageEvent extends ProductDetailEvent {}
