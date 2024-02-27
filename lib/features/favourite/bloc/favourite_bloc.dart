// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/favourite/repo/favourite_repo.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:meta/meta.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavouritesFetchEvent>(favouritesFetchEvent);
    on<FavouriteProductRemovedEvent>(favouriteProductRemovedEvent);
    on<FavouriteNavigateToProductDetailsPageEvent>(
        favouriteNavigateToProductDetailsPageEvent);
  }

  final favRepo = FavouriteRepo();

  FutureOr<void> favouritesFetchEvent(
      FavouritesFetchEvent event, Emitter<FavouriteState> emit) async {
    emit(FavouriteLoadingState());
    final favProductList = await favRepo.fetchFavouriteProducts();
    emit(FavouriteLoadedState(favouriteProducts: favProductList));
  }

  FutureOr<void> favouriteProductRemovedEvent(
      FavouriteProductRemovedEvent event, Emitter<FavouriteState> emit) async {
    await favRepo.deleteProductFromFavourites(event.productModel);
    emit(FavouriteProductRemovedFromListActionState());
    // emit(FavouriteLoadingState());
    final favProductList = await favRepo.fetchFavouriteProducts();
    emit(FavouriteLoadedState(favouriteProducts: favProductList));
  }

  FutureOr<void> favouriteNavigateToProductDetailsPageEvent(
      FavouriteNavigateToProductDetailsPageEvent event,
      Emitter<FavouriteState> emit) {
    emit(FavouriteNavigateToProductDetailsPageActionState(
      product: event.productModel,
    ));
  }
}
