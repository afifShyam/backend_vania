import 'package:backend_vania/app/http/controllers/index.dart';
import 'package:vania/vania.dart';

class UserRoute implements Route {
  @override
  void register() {
    Router.basePrefix('users');

    Router.get("/register", authController.register);
  }
}
