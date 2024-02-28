part of 'product_category_bloc.dart';

@immutable
sealed class ProductCategoryEvent {}

class ProductCategoryFetchDataEvent extends ProductCategoryEvent {
  final int categoryId;

  ProductCategoryFetchDataEvent({required this.categoryId});
}

class ProductCategoryNavigateToProductDetailPageEvent
    extends ProductCategoryEvent {
      final ProductModel productModel;

  ProductCategoryNavigateToProductDetailPageEvent({required this.productModel});
    }
