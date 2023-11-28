import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/services/auth.dart';

class RegisterWithEmail extends StatefulWidget {
  const RegisterWithEmail({Key? key}) : super(key: key);

  @override
  State<RegisterWithEmail> createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String error = '';


  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _password.text;

    dynamic user = await context.read<AuthService>().signUpwithEmailAndPassword(email, password);
    if (user is String) {
      setState(() {
        error = user;
      });
    }
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
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email',
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
            const SizedBox(height: 16.0),
            Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _signUp();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}