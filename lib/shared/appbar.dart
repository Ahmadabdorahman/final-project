// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flower_app/pages/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Cart.dart';

class ProductAndPrice extends StatelessWidget {
  const ProductAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Row(
      children: [
        // (stack(لجعل العداد فوق السله) && Positioned(للتحكم بموقع العداد بالنسبه للسله))
        Stack(
          children: [
            Positioned(
              // ترك مسافه من الاسفل بمقدار 23
              bottom: 23,
              child: Container(
                  child: Text(
                    "${classInstancee.selectedProducts.length}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle)),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOut(),
                  ),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            "JD ${classInstancee.price}",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
