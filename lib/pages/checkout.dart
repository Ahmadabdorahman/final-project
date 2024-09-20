// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flower_app/pages/order_confirming.dart';
import 'package:flower_app/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/appbar.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(93, 64, 55, 1),
        title: Text('CheckOut'),
        actions: [
          ProductAndPrice(),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                  itemCount: classInstancee.selectedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                    classInstancee.selectedProducts[index]
                                        ['Img'],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${classInstancee.selectedProducts[index]['Brand']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Price :${classInstancee.selectedProducts[index]['Price']}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            int count = classInstancee
                                                    .selectedProducts[index]
                                                ['counter'];
                                            classInstancee
                                                .price = classInstancee
                                                    .price -
                                                ((classInstancee
                                                        .selectedProducts[index]
                                                            ['Price']
                                                        .round() as int) *
                                                    (count - 1));
                                            classInstancee.delete(index);
                                          });
                                        },
                                        icon: Icon(Icons.remove)),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color.fromARGB(93, 64, 55, 1),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              classInstancee
                                                  .decreasesCounter(index);
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '${classInstancee.selectedProducts[index]['counter']}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                classInstancee
                                                    .increaseCounter(index);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.add_circle,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryInformationPage(),
                ),
              );
            },
            child: Text(
              "Pay JD${classInstancee.price.round()}",
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Color.fromARGB(93, 64, 55, 1),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.all(12)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ],
      ),
    );
  }
}
