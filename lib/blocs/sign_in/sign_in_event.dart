part of 'sign_in_bloc.dart';

abstract class SignInPageEvent {
  static SignInPageEvent doSignIn() => _DoSignIn();
}

class _DoSignIn extends SignInPageEvent {}
