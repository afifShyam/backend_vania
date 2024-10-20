import 'package:vania/vania.dart';
import 'package:backend_vania/route/api_route.dart';
import 'package:backend_vania/route/web.dart';
import 'package:backend_vania/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  // Perform any initialization tasks after registration
  @override
  Future<void> boot() async {}

  // Register services or perform setup tasks here
  // For example, initializing a NoSQL database like Hive
  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
