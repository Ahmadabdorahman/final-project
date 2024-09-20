// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// مسؤول عن جلب البيانات من قاعدة البيانات calss هذا ال
class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({super.key, required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  CollectionReference users = FirebaseFirestore.instance.collection('USER');
  final credential = FirebaseAuth.instance.currentUser;
  final controller = TextEditingController();

  mydialog(
    Map data,
    dynamic mykey,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: controller,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: '${data[mykey]}')),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({mykey: controller.text});
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "EDIT",
                          style: TextStyle(fontSize: 22),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 22),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 23,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "UserName : ${data['UserName']}",
                    style: TextStyle(fontSize: 21),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mydialog(data, 'UserName');
                        });
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email : ${data['Email']}",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password : ${data['Password']}",
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mydialog(data, 'Password');
                        });
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age : ${data['Age']}",
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mydialog(data, 'Age');
                        });
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title : ${data['Title']}",
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mydialog(data, 'Title');
                        });
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
