import 'package:flutter/material.dart';

class ScaffoldLearn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Sample')),
      body: Text('welcome'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc_sharp), label: 'a'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_rounded), label: 'b'),
        ],
      ),
    );
  }
}
