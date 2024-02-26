part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {}

class ProductFavouriteButtonClickedEvent extends ProductDetailEvent {
  final ProductModel productModel;

  ProductFavouriteButtonClickedEvent({required this.productModel});
}
