import 'package:flutter/material.dart';

class ButonWidget extends StatelessWidget {
  const ButonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () {},
        child: const SizedBox(
          child: Text(
            'Ödeme Al',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ));
  }
}
