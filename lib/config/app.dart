import 'package:vania/vania.dart';
import 'package:backend_vania/app/providers/route_service_provider.dart';

import 'auth.dart';
import 'cors.dart';

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  'cors': cors,
  'auth': authConfig,
  'csrf_except': ['*', 'user/*'],
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
  ],
};
