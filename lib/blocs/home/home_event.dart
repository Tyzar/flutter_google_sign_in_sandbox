part of 'home_bloc.dart';

abstract class HomeEvent {
  static HomeEvent initialize() => _Initialize();

  static HomeEvent signOut() => _SignOut();
}

class _Initialize extends HomeEvent {}

class _SignOut extends HomeEvent {}
