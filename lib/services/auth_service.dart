import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthService {
  final String jwtSecret = 'your-secret-key'; // Replace with a secure key

  // Hash the password using SHA256
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Verify the hashed password
  bool verifyPassword(String inputPassword, String storedPasswordHash) {
    return hashPassword(inputPassword) == storedPasswordHash;
  }

  // Generate a JWT token
  String generateJwtToken(int userId) {
    final jwt = JWT({
      'id': userId,
      'iat': DateTime.now().millisecondsSinceEpoch,
      'exp': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch,
    });

    return jwt.sign(SecretKey(jwtSecret));
  }

  // Verify JWT token
  JWT verifyJwtToken(String token) {
    return JWT.verify(token, SecretKey(jwtSecret));
  }
}
