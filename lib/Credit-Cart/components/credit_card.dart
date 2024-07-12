import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.showBackView,
  });

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool showBackView;

  @override
  Widget build(BuildContext context) {
    // Implement your CreditCardWidget UI here
    return Container(
      child: Column(
        children: [
          Text('Kredi Kart Numarasi: $cardNumber'),
          Text('Son Kullanma Tarihi: $expiryDate'),
          Text('İsim Soyisim: $cardHolderName'),
          Text('CVV: $cvvCode'),
          // Display back view if required
          if (showBackView) ...[
            Text('Showing Back View'),
          ],
        ],
      ),
    );
  }
}