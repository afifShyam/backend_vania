import 'dart:convert';
import 'dart:io';

import 'package:backend_vania/services/index.dart';
import 'package:vania/vania.dart';

import 'package:backend_vania/app/models/index.dart';

class UserProfileController extends Controller {
  Future<Response> update(Request request, int userId) async {
    await request.validate({
      'username': 'string',
      'email': 'email',
      'profile_image': 'file',
    }, {
      'username.string': 'Username must be a string',
      'email.email': 'Email must be a valid email address',
      'profile_image.file': 'Profile image must be a file',
    });

    try {
      String? username = request.input('username');
      String? email = request.input('email');

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
        if (username != null) 'username': username,
        if (email != null) 'email': email,
        'profile_image': avatar != null ? filePath : null,
        'updated_at': DateTime.now().toIso8601String(),
      });
      return Response.json(
        {
          'status': 'success',
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

      String createdAt = user['created_at']?.toString() ?? '';
      String? updatedAt = user['updated_at']?.toString();

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

  Future<Response> getLoggedUser(Request request) async {
    try {
      String token = request.header('Authorization')?.replaceFirst('Bearer ', '') ?? '';
      final decodedToken = AuthUtils.decodeToken(token);
      int? userId = int.tryParse(decodedToken['userId'].toString());

      if (userId == null) {
        return Response.json(
          {'message': 'User not found'},
          404,
        );
      }

      return await show(userId);
    } catch (e) {
      return Response.json(
        {'message': 'An error occurred: $e'},
        520,
      );
    }
  }
}

final UserProfileController userProfileController = UserProfileController();
