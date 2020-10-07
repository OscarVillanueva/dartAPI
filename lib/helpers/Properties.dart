import 'package:jaguar_jwt/jaguar_jwt.dart';

class Properties {
  static const String jwtSecret =
      'CF77232612BE37C0FFE9A165F86D9BE67EEB2E3E39B259969A01DE4C6BB6A392';

  // parse the auth header
  static bool isAuthorized(String authHeader) {
    final parts = authHeader.split(' ');
    if (parts == null || parts.length != 2 || parts[0] != 'Bearer') {
      return false;
    }
    return _isValidToken(parts[1]);
  }

  // verify the token
  static bool _isValidToken(String token) {
    const key = Properties.jwtSecret;
    try {
      verifyJwtHS256Signature(token, key);
      return true;
    } on JwtException {
      print('invalid token');
    }
    return false;
  }
}
