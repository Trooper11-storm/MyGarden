import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,),
    );
  }
}

