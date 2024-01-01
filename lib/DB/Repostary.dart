import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:students/DB/Database.dart';
import 'package:students/MODEL/User.dart';

class Repostary {
  late DatabaseConnection _databaseConnection;

  Repostary() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //insert user

  insertData(table, data) async {
    var conection = await database;
    // print('in repositery');
    //print(data);
    var test = await conection?.insert(table, data);
    print(test);
  }

  //READ ALL RECORD

  readData(table) async {
    var conection = await database;
    return await conection?.query(table);
    // select * from database
  }

  //READ A SINGLE RECORD BY ID

  readDatabyId(table, itemId) async {
    var conection = await database;
    return await conection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //UPDATE USER
  // ignore: non_constant_identifier_names
  UpdateData(table, data, id) async {
    var conecntion = await database;
    // print("object");
    // print(data['age']);

    await conecntion?.update(table, data, where: 'id=?', whereArgs: [id]);
  }

  //DELETE USER
  deleteDatabyid(table, itemId) async {
    var conection = await database;
    await conection?.rawDelete("delete from $table where id=$itemId");
  }
}
