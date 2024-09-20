// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  getdata()async {
    QuerySnapshot Products =await FirebaseFirestore.instance.collection('Product').get();
    items.addAll(Products.docs);
  }

  
}
final List items = [];