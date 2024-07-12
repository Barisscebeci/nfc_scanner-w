import 'package:flutter/material.dart';

class AppBarLearn extends StatelessWidget {
  final IconSizes iconsize = IconSizes();
  final String _title = "Welcome Learn";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title ${_title.length}'),
        leading: Icon(Icons.chevron_left),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.mark_email_unread_sharp)),
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.message_outlined,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

class IconSizes {
  final double iconSmall = 40;
}
