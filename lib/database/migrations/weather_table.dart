import 'package:vania/vania.dart';

class WeatherTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('weather_table', () {
      bigIncrements('weather_id', nullable: false);
      char('city', length: 100);
      decimal('temperature', precision: 2, scale: 1);
      integer('humidity');
      char('weather_description', length: 255);
      timeStamp('recorded_at');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('weather_table');
  }
}
