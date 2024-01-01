import 'package:flutter/foundation.dart';
import 'package:students/DB/Repostary.dart';
import 'package:students/MODEL/User.dart';

class UserService {
  late Repostary _repostary;

  UserService() {
    _repostary = Repostary();
  }
//SAVE USER
  saveUser(USer user) async {
    if (kDebugMode) {
      print('in user servise');
    }
    return await _repostary.insertData("student", user.userMap());
  }

//READ ALL USERS

  reaAllUser() async {
    return await _repostary.readData("student");
  }
  //EDIT USER

  // ignore: non_constant_identifier_names
  Updateuser(USer user, id) async {
    // print(user.age);
    await _repostary.UpdateData('student', user.userMap(), id);
  }

  // ignore: non_constant_identifier_names
  deleteUser(USerid) async {
    return await _repostary.deleteDatabyid('student', USerid);
  }
}
