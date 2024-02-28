part of 'product_category_bloc.dart';

@immutable
sealed class ProductCategoryState {}

abstract class ProductCategoryActionState extends ProductCategoryState {}

final class ProductCategoryInitial extends ProductCategoryState {}

class ProductCategoryLoadingState extends ProductCategoryState {}

class ProductCategoryLoadedState extends ProductCategoryState {
  final List<ProductModel> categorisedProductLists;

  ProductCategoryLoadedState({required this.categorisedProductLists});
}

class ProductCategoryErrorState extends ProductCategoryState {}

class ProductCatgoryNavigateToProductActionState
    extends ProductCategoryActionState {
  final ProductModel productModel;

  ProductCatgoryNavigateToProductActionState({required this.productModel});
}
