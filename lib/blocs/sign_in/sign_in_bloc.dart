import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/services/auth_service.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  final AuthService _authService;

  SignInPageBloc(this._authService) : super(SignInPageState.empty()) {
    on<_DoSignIn>(_doSignIn);
  }

  Future<void> _doSignIn(
      SignInPageEvent event, Emitter<SignInPageState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final gAccount = await _authService.signIn();
      log(gAccount.toString());
      emit(state.copyWith(signInResult: optionOf(right(unit))));
    } catch (e) {
      emit(state.copyWith(
          signInResult:
              optionOf(left(SignInError('Gagal sign in melalui google')))));
    }
  }
}
