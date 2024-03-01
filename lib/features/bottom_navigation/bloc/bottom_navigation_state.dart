part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {
  final int tabIndex;

  const BottomNavigationState({required this.tabIndex});
}

final class BottomNavigationInitialState extends BottomNavigationState {
  const BottomNavigationInitialState({required super.tabIndex});
}
