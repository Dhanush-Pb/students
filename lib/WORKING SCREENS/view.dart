import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students/MODEL/User.dart';

class Viewuser extends StatefulWidget {
  final USer user;

  const Viewuser({super.key, required this.user});

  @override
  State<Viewuser> createState() => _ViewuserState();
}

class _ViewuserState extends State<Viewuser> {
  late USer _userlist;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _userlist = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STUDENT DETAILS..'),
      ),
      body: Center(
        child: Card(
          color: Color.fromARGB(255, 247, 230, 240),
          elevation: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  const Text('full details of student'),
                const SizedBox(
                  height: 10,
                ),
                _userlist.photo == null
                    ? const CircleAvatar(
                        radius: 25,
                        child: Icon(
                          Icons.person,
                          size: 65,
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(_userlist.photo!)),
                      ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text(widget.user.photo ?? ' '),
                    const SizedBox(
                      width: 130,
                      child: Text(
                        'Name :',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      widget.user.name ?? ' ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        'Age :  ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      widget.user.age ?? ' ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        'Reg no :',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      widget.user.Reg ?? ' ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Text(
                        'Phone No :',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      widget.user.contact ?? ' ',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
