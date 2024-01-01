import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students/MODEL/User.dart';
import 'package:students/WORKING%20SCREENS/Userservice.dart';
import 'package:students/screen.dart';

class Edituser2 extends StatefulWidget {
  const Edituser2({
    Key? key,
    required this.user,
    required this.id,
  }) : super(key: key);

  final USer user;
  final int id;

  @override
  State<Edituser2> createState() => _Edituser2State();
}

class _Edituser2State extends State<Edituser2> {
  final _usernamecontroller = TextEditingController();
  final _useragecontroller = TextEditingController();
  final _usercontactcontroller = TextEditingController();
  final _userregcontroller = TextEditingController();
  String? image;

  final _formkey = GlobalKey<FormState>();
  final _Userservice = UserService();

  @override
  void initState() {
    super.initState();
    _usernamecontroller.text = widget.user.name!;
    _useragecontroller.text = widget.user.age ?? '';
    _userregcontroller.text = widget.user.Reg ?? '';
    _usercontactcontroller.text = widget.user.contact ?? '';
    image = widget.user.photo;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.outlined(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.arrow_circle_left_outlined))
        ],
        title: const Text('Edit your details'),
        backgroundColor: const Color.fromARGB(255, 185, 171, 201),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    getimage();
                  },
                  child: const Text('Change Image')),
              Card(
                elevation: 30,
                color: const Color.fromARGB(255, 211, 200, 223),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        image == null
                            ? const CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(File(image!)),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _usernamecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            hintText: 'Enter the Name',
                            labelText: 'NAME',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'change the user Name !';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _useragecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            hintText: 'Change the age',
                            labelText: 'AGE',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'change the user Age !';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _userregcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            hintText: 'Reg NO',
                            labelText: "Reg NO",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Change Reg number !';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _usercontactcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                            hintText: 'Enter the contact',
                            labelText: 'PHONE NO.',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'change the user contact info !';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 252, 252, 252)),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    var user = USer();
                                    user.id = widget.user.id;
                                    user.name = _usernamecontroller.text;
                                    user.age = _useragecontroller.text;
                                    user.contact = _usercontactcontroller.text;
                                    user.Reg = _userregcontroller.text;
                                    user.photo = image;
                                    _Userservice.Updateuser(user, user.id);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const HomeScreen()));
                                    snack(context);
                                  } else {}

                                  //print(result);
                                },
                                icon: const Icon(Icons.update),
                                label: const Text('SAVE')),
                            const SizedBox(
                              width: 70,
                            ),
                            TextButton.icon(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        221, 248, 247, 247)),
                                onPressed: () {
                                  _useragecontroller.text = '';
                                  _usernamecontroller.text = '';
                                  _usercontactcontroller.text = '';
                                  _userregcontroller.text = "";
                                },
                                icon: const Icon(Icons.clear_all),
                                label: const Text('clear')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getimage() async {
    final imagePicker = ImagePicker();
    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          image = pickedImage.path;
        });
        print('Getting image success');
      } else {
        print('User canceled image picking');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}

Future<void> snack(BuildContext ctx) async {
  final _errormessege = 'Update successfully ';
  // snackbar
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(255, 46, 45, 45),
    margin: const EdgeInsets.all(20),
    content: Text(_errormessege),
    duration: const Duration(seconds: 2),
  ));
}
