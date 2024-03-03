// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/cart/model/cart_model.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/product_detail/repo/product_detail_repo.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitialState()) {
    on<ProductDetailInitialEvent>(productDetailInitialEvent);
    on<ProductDetailProductAddedToFavouriteEvent>(
        productDetailProductAddedToFavouriteEvent);
    on<ProductDetailProductRemovedFromFavouriteEvent>(
        productDetailProductRemovedFromFavouriteEvent);
    on<ProductDetailProductAddToCartEvent>(productDetailProductAddToCartEvent);
    on<ProductDetailNavigateToCartPageEvent>(
        productDetailNavigateToCartPageEvent);
    on<ProductDetailNavigateToShipPageOnBuyNowEvent>(
        productDetailNavigateToShipPageOnBuyNowEvent);
  }

  final productRepo = ProductDetailRepo();

  FutureOr<void> productDetailInitialEvent(
      ProductDetailInitialEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoadingState());
    final favProductsList = await productRepo.fetchFavProducts();
    emit(ProductDetailLoadedState(favProducts: favProductsList));
  }

  FutureOr<void> productDetailProductAddedToFavouriteEvent(
      ProductDetailProductAddedToFavouriteEvent event,
      Emitter<ProductDetailState> emit) async {
    await productRepo.addProductToFavourites(event.productModel);
    final favProductsList = await productRepo.fetchFavProducts();
    emit(ProductAddedToFavouriteActionState());
    emit(ProductDetailLoadedState(favProducts: favProductsList));
  }

  FutureOr<void> productDetailProductRemovedFromFavouriteEvent(
      ProductDetailProductRemovedFromFavouriteEvent event,
      Emitter<ProductDetailState> emit) async {
    await productRepo.addProductToFavourites(event.productModel);
    final favProductsList = await productRepo.fetchFavProducts();
    emit(ProductRemovedFromFavouriteActionState());
    emit(ProductDetailLoadedState(favProducts: favProductsList));
  }

  FutureOr<void> productDetailProductAddToCartEvent(
      ProductDetailProductAddToCartEvent event,
      Emitter<ProductDetailState> emit) async {
    await productRepo.addProductToCart(event.productModel);
    final cartItems = await productRepo.getCartItems(event.productModel);
    emit(ProductDetailProductAddedToCartActionState(
      cartItems: cartItems,
    ));
  }

  FutureOr<void> productDetailNavigateToCartPageEvent(
      ProductDetailNavigateToCartPageEvent event,
      Emitter<ProductDetailState> emit) {
    emit(ProductDetailNavigateToCartPageActionState());
  }

  FutureOr<void> productDetailNavigateToShipPageOnBuyNowEvent(
      ProductDetailNavigateToShipPageOnBuyNowEvent event,
      Emitter<ProductDetailState> emit) {
    emit(ProductDetailNavigateToShipPageOnBuyNowActionState());
  }
}
