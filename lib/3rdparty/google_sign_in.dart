import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn createGoogleSignInInstance() {
  return GoogleSignIn(
    scopes: <String>['email'],
  );
}
