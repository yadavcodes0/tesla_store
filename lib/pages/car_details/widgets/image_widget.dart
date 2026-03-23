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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.widget.car.image.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  widget.widget.car.image[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        _buildDotIndicators(widget.widget.car.image.length),
      ],
    );
  }

  Widget _buildDotIndicators(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: _currentImageIndex == index ? 10 : 8,
                height: _currentImageIndex == index ? 10 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentImageIndex == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
