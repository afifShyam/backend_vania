import 'dart:async';
import 'dart:developer';

import 'package:backend_vania/services/index.dart';
import 'package:vania/vania.dart';

class AuthenticateMiddleware extends Middleware {
  @override
  Future<Response> handle(Request req) async {
    String? token = req.header('authorization')?.replaceFirst('Bearer ', '');

    if (token != null || (token ?? '').isNotEmpty) {
      log(
        'message: token is not null:',
      );
      return Response.json({
        'message': 'Unauthorized',
      }, 401);
    }

    try {
      AuthUtils.verifyToken(token!);
      return Response.json({
        'message': 'Unauthorized',
        'token': token,
      }, 401);
    } catch (e) {
      return Response.json({
        'message': 'Unauthorized',
      }, 401);
    }
    // ignore: deprecated_member_use
    // return await next?.handle(req);
    // return Response.json({
    //   'message': 'Unauthorized',
    // }, 401);
  }
}
