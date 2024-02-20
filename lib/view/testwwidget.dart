import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Testwwidget extends StatelessWidget {
  static String routeName = '/';

  const Testwwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Users"),
      ),
      body: const Text(""),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {

        },
        child: const Icon(CupertinoIcons.person_add_solid, color: Colors.white),
      ),
    );
  }
}