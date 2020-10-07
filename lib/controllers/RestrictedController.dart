import 'package:firstapi/firstapi.dart';
import 'package:firstapi/helpers/Properties.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class RestrictedController extends ResourceController {
  @Operation.get()
  Future<Response> restricted(
      @Bind.header("authorization") String authHeader) async {
    // only allow with correct username and password
    if (!Properties.isAuthorized(authHeader)) {
      return Response.forbidden();
    }

    // We are returning a string here, but this could be
    // a file or data from the database.
    return Response.ok('restricted resource');
  }
}
