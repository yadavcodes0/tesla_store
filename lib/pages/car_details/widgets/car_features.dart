import 'package:flutter/material.dart';

class CarFeatures extends StatelessWidget {
  const CarFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/speed.png",
              color: Colors.white,
              height: 50,
            ),
            const SizedBox(height: 4),
            const Text(
              "2.3s",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "from",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const Text(
              "0-60 mph",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/cargo.png",
              color: Colors.white,
              height: 50,
            ),
            const SizedBox(height: 4),
            const Text(
              "28 cu ft",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Best in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const Text(
              "Class Storage",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/road.jpg",
              color: Colors.white,
              height: 50,
            ),
            const SizedBox(height: 4),
            const Text(
              "402mi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Range",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Text(
              "(EPA est.)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
