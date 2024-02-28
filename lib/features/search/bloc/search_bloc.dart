// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/features/home/model/product_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchInitalEvent>(searchInitalEvent);
    on<SearchTextFieldSubmittedEvent>(searchTextFieldSubmittedEvent);
    on<SearchNavigateToProductDetailsPageEvent>(
        searchNavigateToProductDetailsPageEvent);
  }

  FutureOr<void> searchInitalEvent(
      SearchInitalEvent event, Emitter<SearchState> emit) {
    emit(SearchInitialState());
  }

  FutureOr<void> searchTextFieldSubmittedEvent(
      SearchTextFieldSubmittedEvent event, Emitter<SearchState> emit) {
    emit(SearchResultsLoadingState());
    if (event.searchedProducts.isEmpty) {
      emit(SearchNoResultsFoundState());
    } else {
      emit(SearchResultsState(searchedProducts: event.searchedProducts));
    }
  }

  FutureOr<void> searchNavigateToProductDetailsPageEvent(
      SearchNavigateToProductDetailsPageEvent event,
      Emitter<SearchState> emit) {
    emit(SearchNavigateToProductDetailsPageActionState(product: event.product));
  }
}
