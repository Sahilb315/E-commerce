part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

abstract class ProductDetailActionState extends ProductDetailState {}

final class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final List<ProductModel> favProducts;

  ProductDetailLoadedState({required this.favProducts});
}

class ProductDetailErrorState extends ProductDetailState {}

class ProductExistsInFavState extends ProductDetailState {}

class ProductAddedToFavouriteActionState extends ProductDetailActionState {}

class ProductRemovedFromFavouriteActionState extends ProductDetailActionState {}
