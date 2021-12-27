import 'package:fcc_crypto_wallet_firebase_flutter/net/flutterfire.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_button.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthemticationState createState() => _AuthemticationState();
}

class _AuthemticationState extends State<AuthenticationScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final InputDecoration inputDecoration = const InputDecoration(
    hintText: 'password',
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    labelText: 'Password',
    labelStyle: TextStyle(
      color: Colors.white,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  decoration: inputDecoration,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: inputDecoration,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  title: 'Register',
                  onPressed: () async {
                    bool success = await register(_email.text, _password.text);
                    if (success) {
                      print("Successful");
                    }
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  title: "Login",
                  onPressed: () async {
                    bool success = await signIn(_email.text, _password.text);
                    if (success) {
                      print("Successful");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
