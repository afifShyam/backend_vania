import 'dart:async';

import 'package:vania/vania.dart';
import 'package:backend_vania/services/index.dart';

class ValidUser extends Middleware {
  @override
  Future handle(Request req) async {
    // Get the token from the Authorization header
    String? token = req.header('authorization')?.replaceFirst('Bearer ', '');
    if (token == null || token.isEmpty) {
      throw HttpResponseException(
        message: 'Unauthorized',
        code: 401,
      );
    }

    // Verify the token and extract user data
    final decodedToken = AuthUtils.decodeToken(token);
    final requestId = req.params();

    final authenticatedUserId = decodedToken['userId'];

    final requestedUserId = requestId['userId'];

    if (requestedUserId == null || requestedUserId != authenticatedUserId) {
      throw HttpResponseException(
        message: 'You can only edit your own profile',
        code: 403,
      );
    }
  }
}
