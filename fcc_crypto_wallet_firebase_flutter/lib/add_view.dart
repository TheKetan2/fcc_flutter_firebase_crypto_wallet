import 'package:fcc_crypto_wallet_firebase_flutter/net/flutterfire.dart';
import 'package:fcc_crypto_wallet_firebase_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "Bitcoin",
    "Tether",
    "Ethereum",
  ];

  final TextEditingController _amountController = TextEditingController();
  String selectedCoin = "Bitcoin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            DropdownButton(
              value: selectedCoin,
              icon: Icon(Icons.arrow_downward),
              underline: Container(
                height: 3,
                color: Colors.green[100],
              ),
              items: coins
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                  .toList(),
              onChanged: (String? value) {
                print(value);
                setState(
                  () {
                    selectedCoin = value!;
                  },
                );
              },
            ),
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Coin Amount",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CustomButton(
              title: "Add",
              onPressed: () {
                addCoin(
                  selectedCoin,
                  _amountController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
