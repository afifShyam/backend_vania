import 'package:backend_vania/services/index.dart';
import 'dart:io';
import 'package:vania/vania.dart';
import 'package:backend_vania/app/models/index.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    await request.validate({
      'username': 'required|string',
      'password': 'required|min_length:6',
      'email': 'required|email'
    }, {
      'username.required': 'Username is required',
      'username.string': 'Username must be a string',
      'password.required': 'Password is required',
      'password.min_length': 'Password must be at least 6 characters long',
      'email.required': 'Email is required',
      'email.email': 'Invalid email format'
    });

    try {
      final username = request.input('username');
      final password = request.string('password');
      final hashPassword = Hash().make(password);
      final email = request.input('email');

      final userValidata = await User().query().where('username', '=', [username]).first();

      final emailValidate = await User().query().where('email', '=', [email]).first();

      if (userValidata != null) {
        return Response.json(
          {'Error': 'User already exists, Please choose another username'},
          HttpStatus.badRequest,
        );
      }

      if (emailValidate != null) {
        return Response.json(
          {'Error': 'Email already exists, Please choose another email'},
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
        {
          'message': 'User Successfully Registered',
          'data': [
            {
              'username': username,
              'email': email,
              'password': password,
            }
          ],
        },
        HttpStatus.ok,
      );
    } catch (e) {
      return Response.json(
        {
          'Error': '$e,',
        },
        HttpStatus.badGateway,
      );
    }
  }

  Future<Response> login(Request req) async {
    await req.validate(
      {
        'username': 'required|string',
        'password': 'required|min_length:6',
      },
      {
        'username.required': 'Username is required',
        'username.string': 'Username must be a string',
        'password.required': 'Password is required',
        'password.min_length': 'Password must be at least 6 characters long',
      },
    );

    try {
      final username = req.string('username');
      final password = req.string('password');

      final user = await User().query().where('username', '=', [username]).first();

      if (user == null) {
        return Response.json(
          {
            'message': 'User not found',
          },
          HttpStatus.notFound,
        );
      }

      if (!Hash().verify(password, user['password'].replaceAll(' ', ''))) {
        return Response.json(
          {
            'message': 'Wrong password',
          },
          HttpStatus.unauthorized,
        );
      } else {
        final token = AuthUtils.createToken(user['users_id'].toString());

        // Remove sensitive information from user and convert DateTime fields if necessary
        user.removeWhere((key, value) => key == 'password');

        return Response.json(
          {
            'message': 'Login Successful',
            'data': {
              'token': token,
              'username': user['username'].replaceAll(' ', ''),
              'email': user['email'].replaceAll(' ', ''),
            }
          },
          HttpStatus.ok,
        );
      }
    } catch (e) {
      return Response.json(
        {
          'Error': '$e',
        },
        HttpStatus.badGateway,
      );
    }
  }
}

final AuthController authController = AuthController();
