import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcc_crypto_wallet_firebase_flutter/add_view.dart';
import 'package:fcc_crypto_wallet_firebase_flutter/net/api_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    print("hi: ${bitcoin} ${ethereum} ${tether}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double getValues(String id, double amount) {
      id = id.toLowerCase();
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    CollectionReference coin = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Coins');

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: coin.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final document = snapshot.data!.docs[index];

                  return Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 8,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Asset"),
                            Text(document.id),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Amount"),
                            Text("${document?["amount"]}"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Holdings"),
                            Text(
                                "\$${getValues(document.id, document?["amount"]).toStringAsFixed(2)}")
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            coin
                                .doc(document.id)
                                .delete()
                                .then((value) => print("Coin deleted"))
                                .catchError((e) => print("$e"));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[400],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(),
            ),
          );
        },
      ),
    );
  }
}
