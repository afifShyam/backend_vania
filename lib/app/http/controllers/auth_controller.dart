// ignore: implementation_imports
import 'dart:developer';
import 'dart:io';

import 'package:vania/src/exception/validation_exception.dart';
import 'package:vania/vania.dart';

import 'package:backend_vania/app/models/user.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    try {
      request.validate({
        'username': 'required|string',
        'password': 'required|string',
        'email': 'required|email'
      });
    } catch (e) {
      if (e is ValidationException) {
        log('wrong');
        String errorMessage = e.message;
        int code = e.code;
        return Response.json({"message": errorMessage, "result": false}, code);
      } else {
        return Response.json(
          {"message": "unknown error", "result": false},
          520,
        );
      }
    }

    try {
      final username = request.input('username');
      final hashPassword = Hash().make(request.input('password'));
      final email = request.input('email');

      final user =
          await User().query().where('username', '=?', [username]).first();

      if (user != null) {
        return Response.json(
          {
            'message': 'User already exists, please choose another username',
            'result': false
          },
          HttpStatus.badRequest,
        );
      }

      await User().query().insert({
        'username': username,
        'email': email,
        'password': hashPassword,
        'created_at': DateTime.now().toIso8601String(),
      });

      return Response.json(
        {'Message': 'User Successful Register'},
        HttpStatus.ok,
      );
    } catch (e) {
      return Response.json(
        {"message": "unknown error", "result": false},
        HttpStatus.badGateway,
      );
    }
  }

  Future<Response> login(Request req) async {
    try {
      req.validate(
        {
          'username': 'required|string',
          'password': 'required|string',
        },
      );
    } catch (e) {
      if (e is ValidationException) {
        String errorMessage = e.message;
        int code = e.code;
        return Response.json({"message": errorMessage, "result": false}, code);
      } else {
        return Response.json(
            {"message": "unknown error", "result": false}, 520);
      }
    }

    try {
      final username = req.input('username');
      final password = req.input('password');

      final user = await User()
          .query()
          .select(['*']).where('username', '=?', [username]).first();

      if (user == null) {
        return Response.json(
          {'message': 'User not found', 'result': false},
          HttpStatus.notFound,
        );
      }

      if (!Hash().verify(password, user['password'])) {
        return Response.json(
          {'message': 'Wrong password', 'result': false},
          HttpStatus.unauthorized,
        );
      } else {
        final auth = Auth().login(user);
        final token = await auth.createToken(expiresIn: Duration(days: 62));
        user.removeWhere((key, value) => key == 'password');
        return Response.json(
          {
            'message': 'Login Successful',
            'result': true,
            'token': token['access_token'],
            'user': user
          },
          HttpStatus.ok,
        );
      }
    } catch (e) {
      return Response.json(
        {"message": "unknown error", "result": false},
        HttpStatus.badGateway,
      );
    }
  }
}

final AuthController authController = AuthController();
