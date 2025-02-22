import 'package:backend_vania/app/http/controllers/index.dart';
import 'package:backend_vania/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class UserRoute implements Route {
  @override
  void register() {
    Router.basePrefix('users');

    Router.post("/register", authController.register);
    Router.post("/login", authController.login);
    Router.post('/profile/update/{userId}', userProfileController.update);
    Router.get('/profile/{userId}', userProfileController.show).middleware([
      AuthenticateMiddleware(),
    ]);
  }
}
