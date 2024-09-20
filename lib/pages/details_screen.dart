
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../provider/Cart.dart';
import '../shared/appbar.dart';

class Details extends StatefulWidget {
  final QueryDocumentSnapshot Product;
//واستعماله لعرض البيانات في هذه الصفحه Home page متغير لاستقبال بيانات المنتج من

  const Details({super.key, required this.Product});

  @override
  State<Details> createState() => _DetailsState();
}

bool ShowMore = true;

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    //  Cart متغير يتم تخزين فيه نموذج
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        actions: const [
          ProductAndPrice(),
        ],
        backgroundColor: const Color.fromARGB(93, 64, 55, 1),
        title: const Text(
          "Details screen",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.network(
                  widget.Product['Img'],
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.Product['Brand'],
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.Product['Name'],
                            style: const TextStyle(fontSize: 23),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'JD ${widget.Product['Price']}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  // لتقيم المنتجات
                                  RatingBar.builder(
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return const Icon(
                                              Icons
                                                  .sentiment_very_dissatisfied,
                                              color: Color.fromARGB(
                                                  255, 255, 17, 0),
                                            );
                            
                                          case 1:
                                            return const Icon(
                                              Icons.sentiment_dissatisfied,
                                              color: Color.fromARGB(
                                                  255, 216, 65, 65),
                                            );
                            
                                          case 2:
                                            return const Icon(
                                              Icons.sentiment_neutral,
                                              color: Colors.amber,
                                            );
                            
                                          case 3:
                                            return const Icon(
                                              Icons.sentiment_satisfied,
                                              color: Colors.lightGreen,
                                            );
                            
                                          case 4:
                                            return const Icon(
                                              Icons.sentiment_very_satisfied,
                                              color: Color.fromARGB(
                                                  255, 0, 255, 8),
                                            );
                            
                                          default:
                                            return const Text('');
                                        }
                                      },
                                      onRatingUpdate: (rating) {}),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (classInstancee.isProductInCart(widget.Product)) {
                      showSnackBar(
                          context, 'The product is already in the cart');
                    } else {
                      // Product is not in the cart, add it
                      classInstancee.add(widget.Product);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(93, 64, 55, 1),
                  )),
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Details:',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.Product['Details'],
                    style: const TextStyle(fontSize: 18),
                    maxLines: ShowMore ? 2: null,
                    overflow: TextOverflow.fade,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        ShowMore = !ShowMore;
                      });
                    },
                    child: Text(
                      ShowMore ? 'Show more' : 'Show Less',
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ))
              ],
            );
          }),
    );
  }
}
