import 'package:firstapi/firstapi.dart';
import 'package:firstapi/helpers/Properties.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class SignupController extends ResourceController {
  @Operation.post()
  Future<Response> signup() async {
    // Obtenemos el token
    final String token = _signToken(1);

    // send the token back to the user
    return Response.ok(token);
  }

  // creates a JWT with the user ID, expires in 12 hours
  String _signToken(int userId) {
    // Configuramos el JWT
    final claimSet = JwtClaim(
        issuer: 'FirstApi',
        subject: '2020',
        issuedAt: DateTime.now(),
        maxAge: const Duration(hours: 12));

    // Sacamos la cadena de texto secreta para firmar el token
    const String secret = Properties.jwtSecret;

    // Regresamoe el token
    return issueJwtHS256(claimSet, secret);
  }
}
