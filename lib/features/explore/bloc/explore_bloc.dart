// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/repo/home_repo.dart';
import 'package:meta/meta.dart';

import '../../home/model/product_model.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreNavigateToProductCategorisedEvent>(
      exploreNavigateToProductCategorisedEvent,
    );
    on<ExploreNavigateToSearchPageEvent>(exploreNavigateToSearchPageEvent);
    on<ExploreNavigateToFavPageEvent>(exploreNavigateToFavPageEvent);
  }

  FutureOr<void> exploreNavigateToProductCategorisedEvent(
      ExploreNavigateToProductCategorisedEvent event,
      Emitter<ExploreState> emit) {
    emit(ExploreNavigateToProductCategoryPageActionState(
      categoryId: event.categoryId,
      categoryName: event.categoryName,
    ));
  }

  FutureOr<void> exploreNavigateToSearchPageEvent(
      ExploreNavigateToSearchPageEvent event,
      Emitter<ExploreState> emit) async {
    List<ProductModel> products = await HomeRepo().fetchProducts();
    emit(ExploreNavigateToSearchPageActionState(products: products));
  }

  FutureOr<void> exploreNavigateToFavPageEvent(
      ExploreNavigateToFavPageEvent event, Emitter<ExploreState> emit) {
        emit(ExploreNavigateToFavPageActionState());
      }
}
