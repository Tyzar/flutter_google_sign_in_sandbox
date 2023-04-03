import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<Either<AuthApiError, Map<String, dynamic>>> verifyGoogleToken(
      {required String idToken}) async {
    try {
      /// use real server if possible. This is just dummy local server
      final url = Uri.http('127.0.0.1:2000', 'auth/google/verifytoken');
      final resp = await http.post(url, body: {'idToken': idToken});
      if (resp.statusCode != 200) {
        return left(AuthApiError(
            status: resp.statusCode, message: 'Failed to verify token'));
      }

      final respData = jsonDecode(resp.body);
      return right(respData);
    } catch (e) {
      return left(AuthApiError(message: 'Failed to verify token'));
    }
  }
}

class AuthApiError extends Error {
  final int? status;
  final String message;

  AuthApiError({this.status, required this.message});
}
