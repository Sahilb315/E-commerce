part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int tabIndex;

  BottomNavigationState({required this.tabIndex});
}

final class BottomNavigationInitial extends BottomNavigationState {
  BottomNavigationInitial({required super.tabIndex});
}
