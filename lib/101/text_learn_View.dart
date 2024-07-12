import 'package:flutter/material.dart';

class TextLearnView extends StatelessWidget {
  const TextLearnView({Key? key}) : super(key: key);
  final String name = "baris";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome $name ${name.length}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.overline,
              color: Colors.amber[300],
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 2,
            ),
          ),
          Text(
            'Nasilsin $name',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: ProjectStyles.welcomeStyle,
          ),
          Text(
            'Welcome',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: ProjectColors.welcomeColor),
          )
        ],
      ),
    ));
  }
}

class ProjectStyles {
  static TextStyle welcomeStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.amber[900],
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      fontStyle: FontStyle.normal);
}

class ProjectColors {
  static Color get welcomeColor => Colors.red;
}
