import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdvertisingScreen extends StatefulWidget {
  const AdvertisingScreen({super.key});

  @override
  State<AdvertisingScreen> createState() => _AdvertisingScreenState();
}

class _AdvertisingScreenState extends State<AdvertisingScreen> {
  int currentIndex = 0;
  final List<String> imageList = [
    'assets/img/A1.png',
    'assets/img/A2.png',
    'assets/img/A3.jpg',
    'assets/img/A4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CarouselSlider(
                items: imageList.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgUrl),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 5,),
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: imageList.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 15,
                  dotColor: Colors.black,
                  activeDotColor: Color.fromARGB(93, 64, 55, 1),
                  paintStyle: PaintingStyle.fill,
                ),
              ),
      ],
    );
  }
}