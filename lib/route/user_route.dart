import 'package:backend_vania/app/http/controllers/index.dart';
import 'package:backend_vania/app/http/middleware/index.dart';
import 'package:vania/vania.dart';

class UserRoute implements Route {
  @override
  void register() {
    Router.basePrefix('users');

    Router.post("/register", authController.register);
    Router.post("/login", authController.login);
    Router.post('/profile/update/{userId}', userProfileController.update)
        .middleware([AuthenticateMiddleware(), ValidUser()]);
    Router.get('/profile/{userId}', userProfileController.show).middleware([
      AuthenticateMiddleware(),
    ]);
  }
}
