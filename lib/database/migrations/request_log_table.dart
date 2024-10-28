import 'package:vania/vania.dart';

class RequestsLogTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('requests_log', () {
      id();
      integer('user_id', nullable: false);
      char('city', length: 100, nullable: false);
      timeStamp('requested_at', defaultValue: DateTime.now().toString());

      // Foreign key constraint linking user_id in requests_log to id in users table
      //columnName is current column name table
      //referencesTable is table name want to link
      //referencesColumn is column name want to link
      foreign('user_id', 'users', 'users_id',
          onDelete: 'CASCADE', onUpdate: 'CASCADE');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('requests_log');
  }
}
