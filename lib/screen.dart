import 'dart:io';

import 'package:flutter/material.dart';

import 'package:students/MODEL/User.dart';

import 'package:students/WORKING%20SCREENS/sample.dart';
import 'package:students/WORKING%20SCREENS/view.dart';
import 'package:students/editUser2.dart';

import 'WORKING SCREENS/Userservice.dart';
import 'WORKING SCREENS/adduser.dart';

String reg = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<USer> _userlist = [];
  final _userService = UserService();
  final TextEditingController _searchcontroller = TextEditingController();

  get image => null;

  // }
  Future<List<USer>> getAllUserdetails() async {
    await Future.delayed(const Duration(seconds: 1));
    List users = await _userService.reaAllUser();

    RegExp regExp = RegExp(r'^' + reg,
        caseSensitive: false); // Replace '' with your actual search pattern

    _userlist =
        users.where((user) => regExp.hasMatch(user['name'])).map((user) {
      var userModel = USer();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.Reg = user['Reg'];
      userModel.age = user['age'];
      userModel.contact = user['contact'];
      userModel.photo = user['photo'];
      return userModel;
    }).toList();

    return _userlist;
  }

  // ignore: non_constant_identifier_names
  _deleteFormDialog(BuildContext context, USerid) {
    return showDialog(
        context: context,
        // ignore: non_constant_identifier_names
        builder: (Context) {
          return AlertDialog(
            title: const Text(
              'Are you sure delete all details !!',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 60, 60)),
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const ImportScreen()));
              },
              icon: const Icon(Icons.grid_view_rounded)),
        ],
        centerTitle: true,
        // elevation: 20,
        //shadowColor: Colors.white,
        title: const Text(
          'STUDENT LIST ',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 201, 187, 214),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _searchcontroller,
            onChanged: (value) {
              setState(() {
                reg = _searchcontroller.text;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search..',
              contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<USer>>(
            future: getAllUserdetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 69, 82, 226)),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                var list = snapshot.data!;
                Widget children;
                list.isNotEmpty
                    ? children = ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                color: const Color.fromARGB(255, 224, 219, 236),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Viewuser(
                                                  user: _userlist[index],
                                                )));
                                  },
                                  leading: Column(children: [
                                    _userlist[index].photo == null
                                        ? const CircleAvatar(
                                            radius: 25,
                                            child: Icon(
                                              Icons.person,
                                              size: 25,
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundImage: FileImage(
                                                File(_userlist[index].photo!)),
                                          ),
                                  ]),

                                  title: Text(list[index].name!),
                                  subtitle: Text(list[index].Reg!),
                                  // Text(list[index].photo!),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Edituser2(
                                                                user:
                                                                    list[index],
                                                                id: list[index]
                                                                        .id ??
                                                                    0)));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color:
                                                Color.fromARGB(255, 10, 46, 11),
                                          )),
                                      IconButton(
                                          onPressed: () async {
                                            await _deleteFormDialog(
                                                context, _userlist[index].id);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                )),
                          );
                        })
                    : children = const Center(
                        child: Text("Not found"),
                      );
                return children;
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Adduser()));
        },
        backgroundColor: const Color.fromARGB(255, 225, 222, 227),
        child: const Icon(Icons.add),
      ),
    );
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
