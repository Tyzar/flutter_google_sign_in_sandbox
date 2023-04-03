import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_service_app/remote_api/auth_api.dart';

///This service has app scoped lifetime to save logged user information
class AuthService {
  final GoogleSignIn _googleSignIn;
  final AuthApi _authApi;
  final StreamController<GoogleSignInAccount?> authState = StreamController();

  GoogleSignInAccount? _loggedAccount;

  AuthService(this._googleSignIn, this._authApi);

  void initialize() {
    _googleSignIn.onCurrentUserChanged.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(GoogleSignInAccount? account) {
    _loggedAccount = account;

    if (authState.hasListener) {
      authState.add(account);
    }
  }

  Future<GoogleSignInAccount?> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      return null;
    }

    return _verifyIdToken(account);
  }

  Future<bool> isSignedIn() {
    return _googleSignIn.isSignedIn();
  }

  GoogleSignInAccount? getCurrentUser() {
    return _loggedAccount;
  }

  Future<GoogleSignInAccount?> signInSilently() async {
    final account = await _googleSignIn.signInSilently();
    if (account == null) {
      return account;
    }

    return _verifyIdToken(account);
  }

  Future<GoogleSignInAccount?> _verifyIdToken(
      GoogleSignInAccount account) async {
    final authInfo = await account.authentication;
    final idToken = authInfo.idToken;
    if (idToken == null) {
      return null;
    }

    final result = await _authApi.verifyGoogleToken(idToken: idToken);
    if (result.isLeft()) {
      return null;
    }

    _loggedAccount = account;
    return account;
  }

  Future<GoogleSignInAccount?> signOut() {
    return _googleSignIn.signOut();
  }
}
