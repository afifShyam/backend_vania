import 'package:backend_vania/app/http/controllers/index.dart';
import 'package:backend_vania/app/http/middleware/index.dart';
import 'package:vania/vania.dart';

class UserRoute implements Route {
  @override
  void register() {
    //Base Prefix
    Router.basePrefix('users');

    //Routes regis and login
    Router.post("/register", authController.register);
    Router.post("/login", authController.login);

    //Routes profile and authenticate user
    Router.group(
      () {
        Router.post('/profile/update/{userId}', userProfileController.update)
            .middleware([ValidUser()]);
        Router.get('/profile/{userId}', userProfileController.show);
        Router.get('/me', userProfileController.getLoggedUser);
      },
      middleware: [AuthenticateMiddleware()],
    );
  }
}
