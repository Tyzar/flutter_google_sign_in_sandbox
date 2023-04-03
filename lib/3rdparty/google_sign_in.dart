import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn createGoogleSignInInstance({String? oAuthClientId}) {
  return GoogleSignIn(scopes: <String>['email'], clientId: oAuthClientId);
}
