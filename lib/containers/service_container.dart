import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:login_service_app/3rdparty/firebase_remote_config.dart';
import 'package:login_service_app/3rdparty/google_sign_in.dart';
import 'package:login_service_app/remote_api/auth_api.dart';
import 'package:login_service_app/services/auth_service.dart';

class ServiceContainer {
  static ServiceContainer? _instance;

  final List<dynamic> _services = [];

  ServiceContainer._();

  static ServiceContainer get instance {
    return _instance ??= ServiceContainer._();
  }

  Future<void> initialize() async {
    //get client id from remote config
    await initializeRemoteConfig();
    final clientId = getOauthClientId();

    final authService = AuthService(
        createGoogleSignInInstance(oAuthClientId: clientId), AuthApi());
    _services.add(authService);
  }

  T get<T>() {
    T? target;
    for (dynamic service in _services) {
      if (service is T) {
        target = service;
        break;
      }
    }

    assert(target != null);
    return target!;
  }
}
