import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1)));
  await remoteConfig.fetchAndActivate();
}

Map<String, dynamic> getConfig({required String key}) {
  final String strValue = FirebaseRemoteConfig.instance.getString(key);
  return jsonDecode(strValue);
}

String getOauthClientId() {
  final oauthConfig = getConfig(key: 'oauth_client');
  return oauthConfig['client_id'];
}
