// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreNavigateToProductCategorisedEvent>(
      exploreNavigateToProductCategorisedEvent,
    );
  }

  FutureOr<void> exploreNavigateToProductCategorisedEvent(
      ExploreNavigateToProductCategorisedEvent event,
      Emitter<ExploreState> emit) {
    emit(ExploreNavigateToProductCategoryPageActionState(
      categoryId: event.categoryId,
      categoryName: event.categoryName,
    ));
  }
}
