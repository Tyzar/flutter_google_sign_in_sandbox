import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_service_app/services/auth_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthService _authService;

  HomeBloc(this._authService) : super(HomeState.empty()) {
    on<_Initialize>(_doInitialize);
    on<_SignOut>(_doSignOut);
  }

  Future<void> _doInitialize(_Initialize event, Emitter<HomeState> emit) async {
    final loggedUser = _authService.getCurrentUser();
    if (loggedUser == null) {
      emit(state.copyWith(
          getLoggedUserResult:
              optionOf(left(HomePageError('User not found')))));
      return;
    }

    final UserProfile userProfile = UserProfile(
        name: loggedUser.displayName ?? 'Unknown Name',
        email: loggedUser.email,
        urlPhoto: loggedUser.photoUrl);
    emit(state.copyWith(getLoggedUserResult: optionOf(right(userProfile))));
  }

  Future<void> _doSignOut(_SignOut event, Emitter<HomeState> emit) async {
    try {
      await _authService.signOut();
      emit(state.copyWith(signOutResult: optionOf(right(unit))));
    } catch (e) {
      emit(state.copyWith(signOutResult: optionOf(left(SignOutError()))));
    }
  }
}
