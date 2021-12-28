import 'package:cloud_firestore/cloud_firestore.dart';
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

Future<bool> addCoin(String id, String amount) async {
  try {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({"amount": value});
        return true;
      }

      double newAmount = snapshot["amount"] + value;
      transaction.update(documentReference, {"amount": newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}
