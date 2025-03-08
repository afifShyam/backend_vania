import 'dart:async';

import 'package:backend_vania/services/index.dart';
import 'package:vania/vania.dart';

class AuthenticateMiddleware extends Middleware {
  @override
  Future handle(Request req) async {
    String? token = req.header('authorization')?.replaceFirst('Bearer ', '');
    if (token == null || token.isEmpty) {
      throw HttpResponseException(
        message: 'Unauthorized',
        code: 401,
      );
    }
    if (AuthUtils.verifyToken(token) == false) {
      throw HttpResponseException(
        message: 'Invalid token',
        code: 401,
      );
    }
  }
}
