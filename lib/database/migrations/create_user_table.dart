import 'package:vania/vania.dart';

class CreateUserTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('users', () {
      bigIncrements('users_id');
      text('username', zeroFill: false);
      text('password', zeroFill: false);
      char('email', length: 30, zeroFill: false);
      binary('profile_image', nullable: true);
      timeStamp('created_at');
      timeStamp('updated_at', nullable: true);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
