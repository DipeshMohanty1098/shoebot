import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Container(
                margin: const EdgeInsets.all(10.0),
                child: const Text('Loading..', style: TextStyle(fontSize: 25)))),
        const SpinKitWave(color: Colors.yellow, size: 50)
      ],
    ));
  }
}