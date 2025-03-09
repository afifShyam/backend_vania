import 'dart:io';
import 'package:vania/vania.dart';
import 'weather_seeder.dart';
import 'malaysia_location.dart';

void main() async {
  Env().load();
  await DatabaseClient().setup();
  await DatabaseSeeder().registry();
  await DatabaseClient().database?.close();
  exit(0);
}

class DatabaseSeeder {
  registry() async {
    await MalaysiaLocation().run();
    await WeatherSeeder().run();
  }
}
