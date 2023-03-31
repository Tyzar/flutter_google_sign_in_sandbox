part of 'start_app_bloc.dart';

class StartAppState {
  final bool allFinish;
  final Option<Either<StartAppError, bool>> checkSignInResult;

  StartAppState({this.allFinish = false, required this.checkSignInResult});

  static StartAppState empty() => StartAppState(checkSignInResult: none());

  StartAppState copyWith(
          {bool? allFinish,
          Option<Either<StartAppError, bool>>? checkSignInResult}) =>
      StartAppState(
          checkSignInResult: checkSignInResult ?? this.checkSignInResult,
          allFinish: allFinish ?? false);
}

class StartAppError {
  final String errMsg;

  StartAppError(this.errMsg);
}

class CheckSignInError extends StartAppError {
  CheckSignInError() : super('Gagal melakukan pengecekan sign in');
}
