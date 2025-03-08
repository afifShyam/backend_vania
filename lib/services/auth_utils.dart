import 'package:vania/vania.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthUtils {
  // Secret key for signing tokens (should be set from environment variables in production)
  static final String _secret = env<String>('SECRET_KEY');

  /// Generate a JWT token with user ID and expiration
  static String createToken(String userId, {int expiresInDays = 62}) {
    // Set token expiration
    final expiration = DateTime.now().add(Duration(days: expiresInDays));

    // Create and sign the JWT
    final jwt = JWT(
      {
        'userId': userId,
        'exp': expiration.millisecondsSinceEpoch ~/ 1000, // Expiration in seconds
      },
    );

    // Return the signed token
    return jwt.sign(SecretKey(_secret));
  }

  /// Verify a JWT token

  static bool verifyToken(String token) {
    try {
      // Decode and verify the token
      JWT.verify(token, SecretKey(_secret));
      // Verification successful if no exception is thrown
      return true;
    } on JWTExpiredException {
      // Handle token expiration
      print('Token has expired');
      return false;
    } on JWTException catch (e) {
      // Handle other JWT exceptions
      print('Token verification failed: ${e.message}');
      return false;
    }
  }

  /// Decode token payload
  static Map<String, dynamic> decodeToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_secret));
      return jwt.payload;
    } catch (e) {
      throw Exception("Invalid token");
    }
  }
}
