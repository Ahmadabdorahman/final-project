
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/provider/Cart.dart';
import 'package:flower_app/provider/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  final String name, phoneNo, city, street, zipcode;
  const Location({
    super.key,
    required this.name,
    required this.phoneNo,
    required this.city,
    required this.street,
    required this.zipcode,
  });
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final user = FirebaseAuth.instance.currentUser;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController searctcontroller = TextEditingController();
  final Set<Marker> _manymarker = <Marker>{};
  dynamic lat;
  dynamic lng;

  void _addmarker(LatLng markerpoints) {
    setState(() {
      _manymarker.add(Marker(
        markerId: MarkerId('Marker${_manymarker.length}'),
        position: LatLng(markerpoints.latitude, markerpoints.longitude),
        infoWindow: InfoWindow(
            title: 'Position${_manymarker.length}',
            snippet:
                'latitude:${markerpoints.latitude}, longitude: ${markerpoints.longitude}'),
      ));
      lat = markerpoints.latitude;
      lng = markerpoints.longitude;
    });
  }

  static const CameraPosition googlePlex = CameraPosition(
    target: LatLng(31.963158, 35.930359),
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(93, 64, 55, 1),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(188, 231, 231, 231),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searctcontroller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: "Search here", border: InputBorder.none),
                        onChanged: ((value) {
                          print(value);
                        }),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          final place = await LocationService()
                              .getPlace(searctcontroller.text);
                          goToPlace(place['geometry']['location']['lat'],
                              place['geometry']['location']['lng']);
                          setState(() {});
                        },
                        icon: const Icon(Icons.search)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
                markers: _manymarker,
                onTap: (position) async {
                  _addmarker(position);
                },
                initialCameraPosition: googlePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: const WidgetStatePropertyAll(
                        Size(double.maxFinite, double.infinity)),
                    backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(93, 64, 55, 1),
                    )),
                onPressed: () {
                  CollectionReference delivery = FirebaseFirestore.instance
                      .collection('Delivery Information');
                  delivery
                      .doc(user!.uid)
                      .set({
                        'userId': user!.uid,
                        'Name': widget.name,
                        'PhoneNo': widget.phoneNo,
                        'City': widget.city,
                        'Street': widget.street,
                        'Zip Code': widget.zipcode,
                        'product': classInstancee.selectedProducts,
                        'lat': lat,
                        'lng': lng,
                      })
                      .then((value) => print("Info added"))
                      .catchError(
                          (error) => print("Failed to merge data: $error"));

                  Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Home()),
                              );
                            },
                child: const Text(
                  'Sava Location',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 13),
      ),
    );
    _addmarker(LatLng(lat, lng));
  }

  Future<void> goCurrentPosition(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 13),
      ),
    );
    _addmarker(LatLng(lat, lng));
  }
}
