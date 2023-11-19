import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/screens/auth/loginWithEmail.dart';
import 'package:shoebot/screens/auth/registerWithEmail.dart';
import 'package:shoebot/screens/shared/loading.dart';
import 'package:shoebot/services/auth.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool register = false;
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text("S H O E B O T",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                register ?  const Expanded(child: LoginWithEmail()) : const Expanded(child: RegisterWithEmail()) ,
                register ?  const Text('Dont have an account? Sign up') : const Text('Already have an account? Sign in', style: TextStyle(color: Colors.white)),
                ElevatedButton(onPressed: () =>  setState(() {
                  register = !register;
                }), child: register ? const Text('Register') : const Text('Login'),),
                Container( 
                  margin: const EdgeInsets.all(50),
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
        )),
              ],
            ),
          );
  }
}