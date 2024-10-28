// ignore: implementation_imports
import 'package:vania/src/exception/validation_exception.dart';

import 'dart:io';
import 'package:backend_vania/app/models/index.dart';
import 'package:vania/vania.dart';

class UserProfileController extends Controller {
  Future<Response> update(Request request, int id) async {
    try {
      request.validate({
        'username': 'required|string',
        'email': 'required|email',
        'phoneNumber': 'required|numeric',
        'avatar': 'file',
      });
    } catch (e) {
      if (e is ValidationException) {
        String errorMessage = e.message;
        int code = e.code;
        return Response.json({'message': errorMessage, 'result': false}, code);
      } else {
        return Response.json(
            {'message': 'unknown error', 'result': false}, 400);
      }
    }

    try {
      String username = request.input('username');
      String email = request.input('email');
      int phoneNumber = request.input('phoneNumber');
      RequestFile? avatar = request.file('avatar');
      String filePath = '';

      // avatar is optional
      if (avatar != null) {
        filePath = await avatar.store(
            path: 'users/${Auth().id}', filename: avatar.getClientOriginalName);
      }

      await User().query().where('users_id', '==', id).update({
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'avatar': avatar != null ? filePath : null
      });
      return Response.json(
        {'message': 'Profile updated successfully', 'result': true},
        HttpStatus.ok,
      );
    } catch (e) {
      return Response.json({'message': 'unknown error', 'result': false}, 520);
    }
  }
}

final UserProfileController userProfileController = UserProfileController();
