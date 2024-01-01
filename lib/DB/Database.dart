// ignore_for_file: file_names

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db');
    var database = await openDatabase(path, version: 1,
        onCreate: (Database data, int version) async {
      String sql =
          "CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, contact TEXT, Reg TEXT,photo TEXT);";
      await data.execute(sql);
    } // }, onUpgrade: (db, ov, nv) {
        //   if (nv < ov) {
        //     db.execute("alter table student add parent text");
        //   }
        // }

        );
    return database;
  }
}
