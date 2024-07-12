import 'package:flutter/material.dart';

class ButtonLearn extends StatelessWidget {
  const ButtonLearn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button')),
      body: Center(
        child: Column(
          children: [
            TextButton(
              child:
                  Text('Gönder', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                print('Gönderildi');
              },
            ),
            ElevatedButton(onPressed: () {}, child: Text('Gönder')),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add_shopping_cart_sharp),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.all(10)),
                onPressed: () {},
                child: const SizedBox(
                  width: 200,
                  child: Text('Gönder'),
                )),
            Container(
              height: 200,
              color: Colors.pink.shade50,
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black12),
                onPressed: () {},
                child: Text('Place Bid' ,style: Theme.of(context).textTheme.bodyLarge),
                )
          ],
        ),
      ),
    );
  }
}
