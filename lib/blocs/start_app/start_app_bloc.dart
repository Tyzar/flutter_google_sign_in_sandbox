import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/services/auth_service.dart';

part 'start_app_state.dart';

part 'start_app_event.dart';

class StartAppBloc extends Bloc<StartAppEvent, StartAppState> {
  final AuthService _authService;

  StartAppBloc(this._authService) : super(StartAppState.empty()) {
    on<_Initialize>(_doInitialize);
  }

  Future<void> _doInitialize(
      _Initialize event, Emitter<StartAppState> emit) async {
    _authService.initialize();
    return _doCheckSignIn(event, emit);
  }

  Future<void> _doCheckSignIn(
      _Initialize event, Emitter<StartAppState> emit) async {
    try {
      final isSignedIn = await _authService.isSignedIn();
      emit(state.copyWith(
          allFinish: true, checkSignInResult: optionOf(right(isSignedIn))));
    } catch (e) {
      emit(state.copyWith(
          allFinish: true,
          checkSignInResult: optionOf(left(CheckSignInError()))));
    }
  }
}
