// ignore: implementation_imports
import 'dart:convert';

import 'package:vania/src/exception/validation_exception.dart';

import 'dart:io';
import 'package:backend_vania/app/models/index.dart';
import 'package:vania/vania.dart';

class UserProfileController extends Controller {
  Future<Response> update(Request request, int userId) async {
    try {
      request.validate({
        'username': 'string',
        'email': 'email',
        'phone_number': 'numeric',
        'profile_image': 'file',
      });
    } on ValidationException catch (e) {
      return Response.json(
        {
          'message': e.message,
        },
        e.code,
      );
    } catch (e) {
      return Response.json(
        {
          'message': 'unknown error',
        },
        400,
      );
    }

    try {
      String username = request.input('username');
      String email = request.input('email');
      int phoneNumber = request.input('phone_number');
      RequestFile? avatar = request.file('profile_image');
      String filePath = '';

      // avatar is optional
      if (avatar != null) {
        filePath = await avatar.store(
          path: 'users/$userId',
          filename: avatar.getClientOriginalName,
        );
      }

      await User().query().where('users_id', '=', userId).update({
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'profile_image': avatar != null ? filePath : null,
        'updated_at': DateTime.now().toIso8601String(),
      });
      return Response.json(
        {
          'message': 'Profile updated successfully',
        },
        HttpStatus.ok,
      );
    } catch (e) {
      return Response.json(
        {'message': '$e'},
        520,
      );
    }
  }

  Future<Response> show(int userId) async {
    try {
      // Retrieve the user record
      final user = await User().query().where('users_id', '=', userId).first();

      if (user == null) {
        return Response.json(
          {'message': 'User not found'},
          404,
        );
      }

      // Extract and trim the username
      String username = user['username']?.trim() ?? '';

      // Extract other fields
      String email = user['email']?.trim() ?? '';
      num phoneNumber = num.parse(user['phone_number']?.trim() ?? '');
      String createdAt = user['created_at']?.toString() ?? '';
      String updatedAt = user['updated_at']?.toString() ?? '';

      // Handle the profile_image field
      List<int>? profileImageBytes = user['profile_image'];
      String? profileImageBase64;
      if (profileImageBytes != null) {
        profileImageBase64 = base64Encode(profileImageBytes);
      }

      // Construct the response data
      final responseData = {
        'status': 'success',
        'message': 'Successfully Retrive User Profile',
        'data': {
          'users_id': user['users_id'],
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
          'created_at': createdAt,
          'updated_at': updatedAt,
          'profile_image': profileImageBase64,
        }
      };

      return Response.json(responseData);
    } catch (e) {
      return Response.json(
        {'message': 'An error occurred: $e'},
        520,
      );
    }
  }
}

final UserProfileController userProfileController = UserProfileController();
