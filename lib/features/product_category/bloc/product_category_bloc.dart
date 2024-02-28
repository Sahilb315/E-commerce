// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:e_commerce_app/features/product_category/repo/product_category_repo.dart';
import 'package:meta/meta.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc() : super(ProductCategoryInitial()) {
    on<ProductCategoryFetchDataEvent>(productCategoryFetchDataEvent);
    on<ProductCategoryNavigateToProductDetailPageEvent>(
        productCategoryNavigateToProductDetailPageEvent);
  }

  final productCategoryRepo = ProductCategoryRepo();

  FutureOr<void> productCategoryFetchDataEvent(
      ProductCategoryFetchDataEvent event,
      Emitter<ProductCategoryState> emit) async {
    emit(ProductCategoryLoadingState());
    final categorisedProductsList =
        await productCategoryRepo.fetchProductsByCatgory(event.categoryId);
    emit(ProductCategoryLoadedState(
      categorisedProductLists: categorisedProductsList,
    ));
  }

  FutureOr<void> productCategoryNavigateToProductDetailPageEvent(
      ProductCategoryNavigateToProductDetailPageEvent event,
      Emitter<ProductCategoryState> emit) {
    emit(ProductCatgoryNavigateToProductActionState(
      productModel: event.productModel,
    ));
  }
}
