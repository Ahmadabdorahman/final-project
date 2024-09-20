import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/location.dart';
import 'package:flower_app/provider/DeliveryInformation.dart';
import 'package:flutter/material.dart';

class DeliveryInformationPage extends StatelessWidget {
  DeliveryInformationPage({super.key});

  final _deliveryInformationFormKey = GlobalKey<FormState>();
  final DeliveryInformation _deliveryInformation = DeliveryInformation(
    name: '',
    PhoneNumber: '',
    city: '',
    Street: '',
    zipCode: '',
  );

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    TextEditingController name = TextEditingController();
    TextEditingController phoneNo = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController street = TextEditingController();
    TextEditingController zipcode = TextEditingController();

    // Check if user's delivery information exists in Firebase Firestore
    FirebaseFirestore.instance
        .collection('Delivery Information')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // If the document exists, populate the form fields with the existing data
        name.text = documentSnapshot.get('Name');
        phoneNo.text = documentSnapshot.get('PhoneNo');
        city.text = documentSnapshot.get('City');
        street.text = documentSnapshot.get('Street');
        zipcode.text = documentSnapshot.get('Zip Code');
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Delivery Information'),
          backgroundColor: const Color.fromARGB(93, 64, 55, 1),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _deliveryInformationFormKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Name :',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _deliveryInformation.name = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNo,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number :'),
                    validator: (value) {
                      return value!.isEmpty || value.length > 10
                          ? 'Please enter valid Phone Number'
                          : null;
                    },
                    onSaved: (value) {
                      _deliveryInformation.PhoneNumber = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: city,
                    decoration: const InputDecoration(labelText: 'City :'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _deliveryInformation.city = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: street,
                    decoration: const InputDecoration(labelText: 'Street :'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Street';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _deliveryInformation.Street = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: zipcode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Zip Code'),
                    validator: (value) {
                      return value!.isEmpty || value.length != 5
                          ? 'Please enter a valid zip code'
                          : null;
                    },
                    onSaved: (value) {
                      _deliveryInformation.zipCode = value!;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(Size(250, 10)),
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(93, 64, 55, 1),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Location(
                            name: name.text,
                            phoneNo: phoneNo.text,
                            street: street.text,
                            city: city.text,
                            zipcode: zipcode.text,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Pick Location on map',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
