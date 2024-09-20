// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ملف لجمع بيانات من صفحات محدده والتعديل عليها واستعمالها في صفحات اخرى
class Cart with ChangeNotifier {
  List selectedProducts = [];
  int price = 0;
  int productsCounter = 1;

  increaseCounter(int index) {
    if (selectedProducts[index]['counter'] != 5) {
      selectedProducts[index]['counter']++;
      price += selectedProducts[index]['Price'].round() as int;
    }
    notifyListeners();
  }

  decreasesCounter(int index) {
    if (selectedProducts[index]['counter'] != 1) {
      price -= selectedProducts[index]['Price'].round() as int;
      selectedProducts[index]['counter']--;
    }
    notifyListeners();
  }

  bool isProductInCart(QueryDocumentSnapshot product) {
    for (var cartProduct in selectedProducts) {
      if (cartProduct['id'] == product.id) {
        return true; // Product found in cart
      }
    }
    return false; // Product not found in cart
  }

  add(QueryDocumentSnapshot product) {
    selectedProducts.add({
      'Name': product['Name'],
      'Price': product['Price'],
      'id': product.id,
      'Img': product['Img'],
      'counter': productsCounter,
      'Brand':product['Brand'],
    });
    price += product['Price'].round()! as int;
    notifyListeners();
  }

  delete(int index) {
    price -= (selectedProducts[index]['Price'].round()! as int);
    selectedProducts.removeAt(index);
    notifyListeners();
  }
}
