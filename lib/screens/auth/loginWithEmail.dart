import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/services/auth.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({Key? key}) : super(key: key);

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _signIn() async{
    String email = _emailController.text;
    String password = _password.text;
    context.read<AuthService>().signInwithEmailAndPassword(email, password);
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username',
              fillColor: Colors.yellow,
              filled: true),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password',
              fillColor: Colors.yellow,
              filled: true),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _signIn();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}