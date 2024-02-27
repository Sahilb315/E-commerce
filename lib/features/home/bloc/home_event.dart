part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeFavouriteBtnClickedEvent extends HomeEvent {}

class HomeProductTileClickedEvent extends HomeEvent {
  final ProductModel productModel;

  HomeProductTileClickedEvent({
    required this.productModel,
  });
}

