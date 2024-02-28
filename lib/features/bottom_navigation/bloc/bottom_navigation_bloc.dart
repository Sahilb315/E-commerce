// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial(tabIndex: 1)) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is NavigationTabChange) {
        emit(BottomNavigationInitial(tabIndex: event.index));
      }
    });
  }
}
