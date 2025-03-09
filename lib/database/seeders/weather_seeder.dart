import 'package:backend_vania/app/models/index.dart';
import 'package:vania/vania.dart';
import 'package:backend_vania/app/models/weather.dart';

class WeatherSeeder extends Seeder {
  @override
  Future<void> run() async {
    await WeatherModel().query().insert({
      'location_id': 1,
      'temperature': 25.0,
      'humidity': 83,
      'rainfall': 5.0,
      'weather_description': 'Sunny',
      'temp_max': 28.0,
      'temp_min': 23.0,
      'recorded_at': DateTime.now(),
    });
  }
}
