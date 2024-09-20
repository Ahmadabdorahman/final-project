
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/checkout.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/pages/product_display_screen.dart';
import 'package:flower_app/pages/profile_page.dart';
import 'package:flower_app/provider/Cart.dart';
import 'package:flower_app/shared/Advertising_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/User_Information_drawer.dart';
import '../shared/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // تخزين بيانات المستخدم الحالي
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const AdvertisingScreen(),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Best sales',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          categories = null;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDisplay(display(categories)),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        'see all',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: display(categories)),
            ],
          ),
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // المربع الخاص بمعلومات المستخدم
                    Userinfo(
                      documentId: user!.uid,
                    ),

                    ListTile(
                        title: const Text(
                          "Home",
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: const Icon(Icons.home, size: 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        }),
                    ListTile(
                        title:
                            const Text("My products", style: TextStyle(fontSize: 18)),
                        leading: const Icon(Icons.add_shopping_cart, size: 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckOut(),
                            ),
                          );
                        }),
                    ListTile(
                        title: const Text("About", style: TextStyle(fontSize: 18)),
                        leading: const Icon(Icons.help_center, size: 30),
                        onTap: () {}),

                    ListTile(
                        title:
                            const Text("My profile", style: TextStyle(fontSize: 18)),
                        leading: const Icon(Icons.person, size: 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        }),

                    ListTile(
                        title: const Text("Logout", style: TextStyle(fontSize: 18)),
                        leading: const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                        onTap: () {
                          setState(() {
                            FirebaseAuth.instance.signOut();
                          });
                        }),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Developed by Ahmad © 2024",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            actions: const [
              ProductAndPrice(),
            ],
            backgroundColor: const Color.fromARGB(93, 64, 55, 1),
            title: const Text(
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
            .where('categories', isEqualTo: categpries)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // final List Products = snapshot.data!.docs;
          final List<QueryDocumentSnapshot<Object?>> Products =
              snapshot.data!.docs;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //عدد المنتجات في كل صف
                  crossAxisCount: 2,
                  // الطول والعرض لكل منتج
                  childAspectRatio:4  / 8,
                  //المسافه بين كل عامود
                  crossAxisSpacing: 10,
                  // المسافه بين كل صف
                  mainAxisSpacing: 20),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // عند الضغط على المنتج من الصفحه الرئيسه
                    //  Details اولا : سيتم نقلي الى صفحه
                    //  Details ثانيا : سيتم اخذ بيانات المنتج الذي تم الضغط عليه ونقله الى صفحه
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(Product: Products[index]),
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
                            Products[index]['Img'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color.fromARGB(93, 64, 55, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Products[index]['Brand'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "JD ${Products[index]['Price']}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                      IconButton(
                                  color: Colors.black,
                                  iconSize: 30,
                                  onPressed: () {
                                    
                                    if (classInstancee
                                        .isProductInCart(Products[index])) {
                                      classInstancee.increaseCounter(index);
                                    } else {
                                      // Product is not in the cart, add it
                                      classInstancee.add(Products[index]);
                                    }
                                  },
                                  icon: const Icon(Icons.add_circle_outline_rounded)),
                                    
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }
}
