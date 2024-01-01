import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:students/screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    gotoLogin();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'lib/Assets/happy-group-of-kindergarten-kids-holding-a-welcome-text-illustration-free-vector.jpg'),
        ],
      )),
      //  Text(
      //  'Loading....',
      //style: TextStyle(fontSize: 35),
      //),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    //o ignore: use_build_context_synchronously

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }
}
