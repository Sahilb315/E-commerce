part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailState {}

abstract class ProductDetailActionState extends ProductDetailState {}

final class ProductDetailInitialState extends ProductDetailState {}

class ProductExistsInFavState extends ProductDetailState {}

class ProductAddedToFavouriteActionState extends ProductDetailActionState {}

class ProductRemovedFromFavouriteActionState extends ProductDetailActionState {}
