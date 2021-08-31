import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {

  // Create DB & Table
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'mybook.db'),
      onCreate: (database, version) async {
        await database.execute(
          "create table students(id integer primary key autoincrement, code text, name, text, dept text, phone text)");
      },
      version: 1,
    );
  }


}