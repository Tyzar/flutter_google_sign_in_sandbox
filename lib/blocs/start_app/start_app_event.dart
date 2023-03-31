part of 'start_app_bloc.dart';

abstract class StartAppEvent {
  static StartAppEvent initialize() => _Initialize();
}

class _Initialize extends StartAppEvent {}
