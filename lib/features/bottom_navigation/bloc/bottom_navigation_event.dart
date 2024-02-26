part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class NavigationTabChange extends BottomNavigationEvent {
  final int index;

  NavigationTabChange({required this.index});
}
