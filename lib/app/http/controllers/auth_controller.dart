import 'package:backend_vania/services/index.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {
  AuthService authService = AuthService();

  Future<Response> register(Request request) async {
    final username = request.body['username'];
    final password = request.body['password'];
    final email = request.body['email'];

    request.validate({
      username: 'required|string',
      password: 'required|string',
      email: 'required|email'
    });
    final hashPassword = authService.hashPassword(password);
    request.query().selec();
    return Response(
        data: 'User Successful Register',
        responseType: ResponseType.json,
        httpStatusCode: 201);
  }

  Future<Response> login(Request req) async {
    final body = req.body;
    final username = body['username'];
    final password = body['password'];

    req.validate(
      {
        username: 'required|string',
        password: 'required|string',
      },
    );

    final user =
        req.query().select(['* users']).where('email', '=?', [username]);

    if (user == null ||
        !authService.verifyPassword(password, user[0]['password'])) {
      return Response(httpStatusCode: 401, data: 'Invalid password');
    }

    final token = authService.generateJwtToken(user[0]['id']);
    return Response.json({'token': token});
  }
}

final AuthController authController = AuthController();
