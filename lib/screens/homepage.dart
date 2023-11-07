import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoebot/services/auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override 
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() {
    context.read<AuthService>().signOut();
  }
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>().displayName;
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(firebaseUser!)
          ),
          Center(
          child: ElevatedButton(onPressed: signOut, child: const Text('Sign Out')),
        ),]
      )
    );
  }
}