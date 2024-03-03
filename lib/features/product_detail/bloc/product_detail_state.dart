part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

abstract class ProductDetailActionState extends ProductDetailState {}

final class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final List<ProductModel> favProducts;
  // final List<ProductModel> cartProducts;

  ProductDetailLoadedState({
    required this.favProducts,
    // required this.cartProducts,
  });
}

class ProductDetailErrorState extends ProductDetailState {}

class ProductExistsInFavState extends ProductDetailState {}

class ProductAddedToFavouriteActionState extends ProductDetailActionState {}

class ProductRemovedFromFavouriteActionState extends ProductDetailActionState {}

class ProductDetailProductAddedToCartActionState
    extends ProductDetailActionState {
  final List<CartModel> cartItems;

  ProductDetailProductAddedToCartActionState({required this.cartItems});
}

class ProductDetailNavigateToCartPageActionState
    extends ProductDetailActionState {}

class ProductDetailNavigateToShipPageOnBuyNowActionState
    extends ProductDetailActionState {}
