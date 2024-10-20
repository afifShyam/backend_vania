import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('users', () {
      bigIncrements('users_id');
      char('username', length: 30, zeroFill: false);
      longText('password', zeroFill: false);
      char('email', length: 30, zeroFill: false);
      binary('profile_image', nullable: true);
      dateTime('created_at');
      dateTime('updated_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
