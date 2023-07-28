import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../car_details.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    Key? key,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Size size;
  final CarDetails widget;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          itemCount: widget.widget.car.image.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.widget.car.image[index],
              ),
            );
          },
        ),
        _buildDotIndicators(widget.widget.car.image.length),
      ],
    );
  }

  Widget _buildDotIndicators(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentImageIndex == index ? Colors.white : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
