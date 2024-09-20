// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_init_to_null

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/provider/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/appbar.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay(Widget display, {super.key});
  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

var categories;

class _ProductDisplayState extends State<ProductDisplay> {
  String TypeOfProduct = 'ALL';
  @override
  Widget build(BuildContext context) {
    // تخزين بيانات المستخدم الحالي
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      'Categories :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20, left: 35, right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  categories = 'Women';
                                  TypeOfProduct = "Women's watch";
                                });
                              }),
                              onDoubleTap: () {
                                setState(() {
                                  categories = null;
                                  TypeOfProduct = 'ALL';
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                    'assets/imgs/9007701-1812665173.jpg',
                                  )),
                                ),
                              ),
                            ),
                            Text(
                              "Women",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  categories = "smart";
                                  TypeOfProduct = "smart watch";
                                });
                              }),
                              onDoubleTap: () {
                                setState(() {
                                  categories = null;
                                  TypeOfProduct = 'ALL';
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                    'assets/imgs/images.jpg',
                                  )),
                                ),
                              ),
                            ),
                            Text(
                              "smart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  categories = "Men";
                                  TypeOfProduct = "Men's watch";
                                });
                              }),
                              onDoubleTap: () {
                                setState(() {
                                  categories = null;
                                  TypeOfProduct = 'ALL';
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                    'assets/imgs/man.webp',
                                  )),
                                ),
                              ),
                            ),
                            Text(
                              "Men",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      TypeOfProduct,
                      style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
              Expanded(
                child: SizedBox(child: display(categories)),
              ),
            ],
          ),
          appBar: AppBar(
            actions: [
              ProductAndPrice(),
            ],
            backgroundColor: Color.fromARGB(93, 64, 55, 1),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            ),
          )),
    );
  }

  Widget display(categpries) {
    final classInstancee = Provider.of<Cart>(context, listen: false);
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Products")
            .where('Categories', isEqualTo: categpries)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // final List Products = snapshot.data!.docs;
          final List<QueryDocumentSnapshot<Object?>> products =
              snapshot.data!.docs;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //عدد المنتجات في كل صف
                  crossAxisCount: 2,
                  // الطول والعرض لكل منتج
                  childAspectRatio: 4 / 8,
                  //المسافه بين كل عامود
                  crossAxisSpacing: 10,
                  // المسافه بين كل صف
                  mainAxisSpacing: 20),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // عند الضغط على المنتج من الصفحه الرئيسه
                    //  Details اولا : سيتم نقلي الى صفحه
                    //  Details ثانيا : سيتم اخذ بيانات المنتج الذي تم الضغط عليه ونقله الى صفحه
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(Product: products[index]),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width * .7,
                          child: Image.network(
                            products[index]['Img'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        color: Color.fromARGB(93, 64, 55, 1),
                        child: 
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index]['Brand'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$ ${products[index]['Price']}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                        IconButton(
                                color: Colors.black,
                                iconSize: 30,
                                onPressed: () {
                                  if (classInstancee
                                      .isProductInCart(products[index])) {
                                    classInstancee.increaseCounter(index);
                                  } else {
                                    // Product is not in the cart, add it
                                    classInstancee.add(products[index]);
                                  }
                                },
                                icon: Icon(Icons.add_circle_outline_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ),
              
                    ],
                  ),
                );
              });
        });
  }
}
