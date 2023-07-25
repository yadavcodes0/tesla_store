import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

import '../car_details.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final CarDetails widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height * 0.30,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: AnotherCarousel(
        dotHorizontalPadding: 10,
        animationCurve: Curves.bounceInOut,
        dotColor: Colors.grey,
        dotSpacing: 16.0,
        dotIncreaseSize: 1.1,
        dotSize: 10,
        dotBgColor: Colors.transparent,
        boxFit: BoxFit.contain,
        autoplay: false,
        images: [
          AssetImage(widget.car.image.first),
          AssetImage(widget.car.image[1]),
          AssetImage(widget.car.image[2]),
        ],
      ),
    );
  }
}
