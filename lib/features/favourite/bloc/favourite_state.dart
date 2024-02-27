part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteState {}

abstract class FavouriteActionState extends FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  final List<ProductModel> favouriteProducts;

  FavouriteLoadedState({required this.favouriteProducts});
}

class FavouriteErrorState extends FavouriteState {}

class FavouriteProductRemovedFromListActionState extends FavouriteActionState {}

class FavouriteNavigateToProductDetailsPageActionState
    extends FavouriteActionState {
      final ProductModel product;

      FavouriteNavigateToProductDetailsPageActionState({required this.product});
    }
