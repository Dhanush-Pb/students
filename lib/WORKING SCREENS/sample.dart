import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students/MODEL/User.dart';
import 'package:students/WORKING%20SCREENS/Userservice.dart';

import 'package:students/WORKING%20SCREENS/view.dart';
import 'package:students/editUser2.dart';
import 'package:students/screen.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<ImportScreen> {
  late List<USer> _userlist = [];
  final _userService = UserService();

  Future<List<USer>> getAllUserdetails() async {
    List users = await _userService.reaAllUser();

    _userlist = users.map((user) {
      var userModel = USer();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.Reg = user['Reg'];
      userModel.age = user['age'];
      userModel.contact = user['contact'];
      userModel.photo = user['photo'];
      _userlist.add(userModel);
      return userModel;
    }).toList();
    return _userlist;
  }

  _deleteFormDialog(BuildContext context, USerid) {
    return showDialog(
        context: context,
        builder: (Context) {
          return AlertDialog(
            title: const Text(
              'Are you sure delete all details !!',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 216, 41, 41)),
                  onPressed: () async {
                    snack(context);
                    Navigator.of(context).pop();
                    var result = await _userService.deleteUser(USerid);
                    if (result != null) {
                      getAllUserdetails();
                    }
                    ();
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 224, 44)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('close')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'STUDENT LIST',
            style:
                TextStyle(fontSize: 15, color: Color.fromARGB(255, 6, 5, 22)),
          ),
          centerTitle: true,
          //elevation: 20,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                icon: const Icon(Icons.list))
          ],
          backgroundColor: const Color.fromARGB(255, 218, 198, 232),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<USer>>(
                future: getAllUserdetails(),
                builder: (context, AsyncSnapshot<List<USer>> user) {
                  var list = user.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust number of columns as needed
                      crossAxisSpacing: 10.0, // Adjust spacing between tiles
                      mainAxisSpacing: 20.0, // Adjust spacing between rows
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final user = list[index];
                      return Card(
                        color: const Color.fromARGB(255, 176, 161, 191),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Viewuser(user: user),
                              ),
                            );
                          },
                          child: Center(
                            //child: Padding(
                            // padding: const EdgeInsets.only(top: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  list[index].photo == null
                                      ? const CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.person,
                                            size: 15,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 42,
                                          backgroundImage: FileImage(
                                              File(list[index].photo!)),
                                        ),
                                  //const Icon(Icons.person),
                                  // Text(list[index].photo!),
                                  Text(user.name!),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      //  mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) => Edituser2(
                                                  user: user,
                                                  id: user.id ?? 0,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color:
                                                Color.fromARGB(255, 10, 46, 11),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await _deleteFormDialog(
                                                context, user.id);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }

  Future<void> snack(BuildContext ctx) async {
    final _errormessege = ' deleted  successfully ';
    // snackbar
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 46, 45, 45),
      margin: const EdgeInsets.all(20),
      content: Text(_errormessege),
      duration: const Duration(seconds: 3),
    ));
  }
}
