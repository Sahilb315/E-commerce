// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/home/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeFetchProductsEvent);
    on<HomeFavouriteBtnClickedEvent>(homeFavouriteBtnClickedEvent);
    on<HomeProductTileClickedEvent>(homeProductTileClickedEvent);
  }

  final homeRepo = HomeRepo();

  FutureOr<void> homeFetchProductsEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final productsList = await homeRepo.fetchProducts();
    final bestSellerProductsList = await homeRepo.fetchBestSellerProducts();
    emit(HomeSuccessState(
      products: productsList,
      bestSellerProducts: bestSellerProductsList,
    ));
  }

  FutureOr<void> homeFavouriteBtnClickedEvent(
      HomeFavouriteBtnClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavouritePageActionState());
  }

  FutureOr<void> homeProductTileClickedEvent(
      HomeProductTileClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToProductPageActionState(productModel: event.productModel));
  }
}
