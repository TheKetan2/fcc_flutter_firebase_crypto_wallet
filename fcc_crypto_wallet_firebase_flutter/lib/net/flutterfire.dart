import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(auth.user?.uid.toString());
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      print("The password id too weak.");
    } else if (e.code == "email-already-in-use") {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(auth.user?.uid.toString());
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      print("The password id too weak.");
    } else if (e.code == "email-already-in-use") {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
