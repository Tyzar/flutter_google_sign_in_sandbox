import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';

///This service has app scoped lifetime to save logged user information
class AuthService {
  final GoogleSignIn _googleSignIn;
  final StreamController<GoogleSignInAccount?> authState = StreamController();

  GoogleSignInAccount? _loggedAccount;

  AuthService(this._googleSignIn);

  void initialize() {
    _googleSignIn.onCurrentUserChanged.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(GoogleSignInAccount? account) {
    _loggedAccount = account;

    if (authState.hasListener) {
      authState.add(account);
    }
  }

  Future<GoogleSignInAccount?> signIn() {
    return _googleSignIn.signIn();
  }

  Future<bool> isSignedIn() {
    return _googleSignIn.isSignedIn();
  }

  GoogleSignInAccount? getCurrentUser() {
    return _loggedAccount;
  }

  Future<GoogleSignInAccount?> signInSilently() {
    return _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signOut() {
    return _googleSignIn.signOut();
  }
}
