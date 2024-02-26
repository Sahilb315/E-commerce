part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductModel> products;
  final List<ProductModel> bestSellerProducts;

  HomeSuccessState({
    required this.products,
    required this.bestSellerProducts,
  });
}

class HomeErrorState extends HomeState {}

class HomeNavigateToFavouritePageActionState extends HomeActionState {}

class HomeNavigateToProductPageActionState extends HomeActionState {
  final ProductModel productModel;

  HomeNavigateToProductPageActionState({required this.productModel});
}
