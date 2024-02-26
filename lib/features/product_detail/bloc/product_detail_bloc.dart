// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/product_detail/repo/product_detail_repo.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitialState()) {
    on<ProductFavouriteButtonClickedEvent>(productFavouriteButtonClickedEvent);
  }

  final productRepo = ProductDetailRepo();

  FutureOr<void> productFavouriteButtonClickedEvent(
      ProductFavouriteButtonClickedEvent event,
      Emitter<ProductDetailState> emit) async {
    final productRemovedOrAdded =
        await productRepo.addProductToFavourites(event.productModel);
    if (productRemovedOrAdded) {
      emit(ProductAddedToFavouriteActionState());
      // When the product is added it tells that the product exits in the fav list
      emit(ProductExistsInFavState());
    } else {
      emit(ProductRemovedFromFavouriteActionState());
    }
  }
}
