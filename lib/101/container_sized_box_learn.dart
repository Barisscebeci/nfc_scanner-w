import 'package:flutter/material.dart';

class ContainerSizedBoxLearn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(
          width: 300,
          height: 200,
          child: Text('a' * 500),
        ),
        const SizedBox.shrink(),
        SizedBox.square(
          dimension: 50,
          child: Text('b' * 50),
        ),
        Container(
          height: 50,
          
          constraints: const BoxConstraints(maxHeight: 120, maxWidth: 200, minWidth: 100, minHeight: 50),
          child: Text('aa' * 1),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.black12]),
            boxShadow: const [BoxShadow(color: Colors.cyanAccent, offset: Offset(0.1, 1), blurRadius: 12)],
            border: Border.all(width: 10, color: Colors.white12),
          ),
        )
      ],)
    );
  }

}