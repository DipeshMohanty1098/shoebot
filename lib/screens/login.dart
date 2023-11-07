import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/screens/shared/loading.dart';
import 'package:shoebot/services/auth.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  void click() {
    context.read<AuthService>().signInWithGoogle();
  }

  //final googleLogo = Image.asset('assets/google_logo.png', height: 10);

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
          backgroundColor: Colors.black,
            body: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text("S H O E B O T",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
            floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            click();
              setState(() {
              loading = true;
          });
          },
          child: const Center(
            child: Text('Login or Sign Up with Google'),
          ),
        ),
      ),
          );
  }
}