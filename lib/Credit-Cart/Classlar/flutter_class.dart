import 'package:flutter/material.dart';
import '../components/flutter_project_style.dart';


class CardTextStyle extends StatelessWidget {
  const CardTextStyle({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      
      style: ProjectStyle.projectTheme,
    );
  }
}

