part of 'sign_in_bloc.dart';

class SignInPageState {
  final bool isLoading;
  final Option<Either<SignInError, Unit>> signInResult;

  SignInPageState({this.isLoading = false, required this.signInResult});

  static SignInPageState empty() => SignInPageState(signInResult: none());

  SignInPageState copyWith(
          {bool? isLoading, Option<Either<SignInError, Unit>>? signInResult}) =>
      SignInPageState(
          isLoading: isLoading ?? false,
          signInResult: signInResult ?? this.signInResult);
}

class SignInError {
  final String errorMsg;

  SignInError(this.errorMsg);
}
