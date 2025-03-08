import 'dart:io';
import 'package:backend_vania/database/migrations/index.dart';
import 'package:vania/vania.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await CreateUserTable().up();
    await RequestsLogTable().up();
    await LocationTable().up();
    await WeatherTable().up();
  }

  dropTables() async {
    await CreateUserTable().down();
    await RequestsLogTable().down();
    await LocationTable().down();
    await WeatherTable().down();
  }
}
