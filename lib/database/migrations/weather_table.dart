import 'package:vania/vania.dart';

class WeatherTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('weather_table', () {
      bigIncrements('weather_id', nullable: false);
      integer('location_id', nullable: false);
      decimal('temperature', precision: 5, scale: 2);
      integer('humidity');
      decimal('rainfall', precision: 5, scale: 2);
      string('weather_description', length: 255);
      decimal('temp_max', precision: 5, scale: 2);
      decimal('temp_min', precision: 5, scale: 2);
      timeStamp('recorded_at');
      foreign('location_id', 'location', 'location_id', onDelete: 'CASCADE', onUpdate: 'CASCADE');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('weather_table');
  }
}
