import 'package:vania/vania.dart';

class LocationTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('location', () {
      bigIncrements('location_id', nullable: false);
      char('city', length: 100, nullable: false);
      char('country', length: 100, nullable: false);
      decimal('latitude', precision: 9, scale: 6);
      decimal('longitude', precision: 9, scale: 6);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('location');
  }
}
