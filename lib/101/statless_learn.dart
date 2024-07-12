import 'package:flutter/material.dart';

class StatlessLearn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Column(
        children:  [
              TitleTextWidget(text: "veli",),
              TitleTextWidget(text: "veli1",),
              TitleTextWidget(text: "veli2",),
              TitleTextWidget(text: "veli3",),
            ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TitleTextWidget extends StatelessWidget {
  TitleTextWidget({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}

