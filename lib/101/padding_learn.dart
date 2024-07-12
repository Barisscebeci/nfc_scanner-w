import 'package:flutter/material.dart';

class PaddingLearn extends StatelessWidget {
  const PaddingLearn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: Container(color: Colors.white, height: 100)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            color: Colors.white,
            height: 100,
          ),
        ),
        Padding(padding: ProjectPadding.pagePaddingRightOnly+ProjectPadding.pagePaddingVertical,
        child: Text('veli'),)
      ]),
    );
  }
}


class ProjectPadding {
  static const pagePaddingVertical = EdgeInsets.symmetric(vertical: 10);
  static const pagePaddingRightOnly = EdgeInsets.only(right: 20);
}