import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// مسؤول عن جلب البيانات من قاعدة البيانات calss هذا ال
class Userinfo extends StatelessWidget {
  final String documentId;

  const Userinfo({super.key, required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('USER');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(93, 64, 55, 1),
            ),
            accountEmail: Text(
              data['Email'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            accountName: Text(data['UserName'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          );
        }

        return const Text("loading");
      },
    );
  }
}
