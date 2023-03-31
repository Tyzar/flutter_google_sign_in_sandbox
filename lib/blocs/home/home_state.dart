part of 'home_bloc.dart';

class HomeState {
  final Option<Either<HomePageError, UserProfile>> getLoggedUserResult;
  final Option<Either<SignOutError, Unit>> signOutResult;

  HomeState({required this.getLoggedUserResult, required this.signOutResult});

  static HomeState empty() =>
      HomeState(getLoggedUserResult: none(), signOutResult: none());

  HomeState copyWith(
          {Option<Either<HomePageError, UserProfile>>?
              getLoggedUserResult,
          Option<Either<SignOutError, Unit>>? signOutResult}) =>
      HomeState(
          getLoggedUserResult: getLoggedUserResult ?? this.getLoggedUserResult,
          signOutResult: signOutResult ?? this.signOutResult);
}

class UserProfile {
  final String name;
  final String email;
  final String? urlPhoto;

  UserProfile({required this.name, required this.email, this.urlPhoto});
}

class HomePageError {
  final String errMsg;

  HomePageError(this.errMsg);
}

class SignOutError extends HomePageError {
  SignOutError() : super('Gagal sign out');
}
