import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.green,),
    );
  }
}