import 'dart:ui';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:my_flutter_app/Credit-Cart/components/buton_widget.dart';
import 'package:my_flutter_app/Credit-Cart/components/cvv_field.dart';
import 'package:my_flutter_app/Credit-Cart/components/input_field.dart';
import 'package:my_flutter_app/Credit-Cart/components/input_formatters.dart';
import 'package:u_credit_card/u_credit_card.dart';
import '../components/flutter_project_style.dart';
import 'flutter_class.dart';
import '../components/combinated_date_field.dart';
import 'nfc_service.dart';

class FlutterCreditCardNfc extends StatefulWidget {
  const FlutterCreditCardNfc({super.key});

  @override
  _FlutterCreditCardNfcState createState() => _FlutterCreditCardNfcState();
}

class _FlutterCreditCardNfcState extends State<FlutterCreditCardNfc> {
  final TextEditingController cardHolderFullNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController validThruController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool showBackView = false;
  bool _isBlurred = false;

  void _readNfc() async {
      bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Cihazınız NFC desteklemiyor.'),
        ),
      );
      return;
    }
    setState(() {
      _isBlurred = true;
    });
    try {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/NFC-Animation.json'),
              const Text('Lütfen kartınızı okutunuz'),
            ],
          ),
        ),
      ).then((_) {
        setState(() {
          _isBlurred = false;
        });
      });

      NfcData result = await NfcService.read();
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Okuma işlemi bitince dialogu kapat

      List<String> contentLines = result.content.split('\n');
      print('Content lines: $contentLines');
      setState(() {
        cardHolderFullNameController.text = contentLines.isNotEmpty && contentLines.length > 0 ? contentLines[0] : 'deneme123';
        cardNumberController.text = contentLines.isNotEmpty && contentLines.length > 1 ? contentLines[1] : 'deneme';
        validThruController.text = contentLines.isNotEmpty && contentLines.length > 2 ? contentLines[2] : '22/22';
        cvvController.text = contentLines.isNotEmpty && contentLines.length > 3 ? contentLines[3] : '333';
        _isBlurred = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      setState(() {
        _isBlurred = false;
      });
      print('NFC okuma hatası: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('NFC okuma hatası: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Ödeme Al'),
        leading: IconButton(
          onPressed: () {
            //menü işlemleri için onpressed özelliği ile burada işlem yapabiliriz.
          },
          icon: Icon(Icons.menu),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
      ),
      body: Padding(
        padding: ProjectPadding.pagePaddingFull,
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CreditCardUi(
                  cardHolderFullName: cardHolderFullNameController.text,
                  cardNumber: cardNumberController.text,
                  validThru: validThruController.text,
                  showValidFrom: false,
                  topLeftColor: Colors.blue,
                  doesSupportNfc: true,
                  placeNfcIconAtTheEnd: true,
                  cardType: CardType.debit,
                  cardProviderLogoPosition: CardProviderLogoPosition.right,
                  enableFlipping: true,
                  cvvNumber: cvvController.text,
                ),
                const Padding(padding: ProjectPadding.pagePaddingTop),
                const CardTextStyle(
                  text: 'Kart Üzerindeki Ad, Soyad',
                ),
                InputField(
                  key: const Key('cardHolderFullName'),
                  controller: cardHolderFullNameController,
                  labelText: '',
                  hintText: 'Baris Cebeci',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Zorunlu alan';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  inputFormatters: [],
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const Padding(padding: ProjectPadding.pagePaddingTop),
                const CardTextStyle(
                  text: 'Kart Numarasi',
                ),
                InputField(
                  key: const Key('cardNumber'),
                  controller: cardNumberController,
                  labelText: '',
                  hintText: 'Kart Numarasi',
                  validate: (valueNumber) {
                    if (valueNumber == null || valueNumber.isEmpty) {
                      return 'Zorunlu alan';
                    }
                    if (valueNumber.replaceAll(' ', '').length < 16) {
                      return 'Lütfen Kart Numarasını Doğru Giriniz';
                    }
                    return null;
                  },
                  inputFormatters: [
                    CardNumberInputFormatter()
                  ], // Kart numarası formatlayıcı
                  maxLength: 19,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const Row(
                  children: [
                    Expanded(
                      child: CardTextStyle(
                        text: 'VALID THRU',
                      ),
                    ),
                    Padding(padding: ProjectPadding.pageOnlyRow),
                    Expanded(
                      child: CardTextStyle(
                        text: 'CVV',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CombinedDateField(
                        key: const Key('MonthYear'),
                        controller: validThruController,
                        labelText: '',
                        hintText: '08/24',
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Zorunlu alan';
                          }
                          if (value.length < 5) {
                            return 'Minimum 4 karakter girmelisiniz';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                          CardMonthInputFormatter(),
                        ],
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(padding: ProjectPadding.pagePaddingOnly),
                    Expanded(
                      child: CvvField(
                        key: const Key('CVV'),
                        controller: cvvController,
                        labelText: '',
                        hintText: 'CVV',
                        validate: (valueCVV) {
                          if (valueCVV == null || valueCVV.isEmpty) {
                            return 'Zorunlu alan';
                          }
                          if (valueCVV.length < 3) {
                            return 'Minimum 3 karakter girmelisiniz';
                          }
                          return null;
                        },
                        onChanged: (valueCVV) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(padding: ProjectPadding.pagePaddingTop),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _readNfc,
                        child: const Text('Read NFC'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(padding: ProjectPadding.pageOnlyRow),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          NfcData result = await NfcService.write(
                            "path/to/write",
                            "Label to Write",
                          );
                          print(result.content);
                        },
                        child: const Text('Write NFC'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButonWidget(),
                  ],
                ),
                if (_isBlurred)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: FlutterCreditCardNfc()));