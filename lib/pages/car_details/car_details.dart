import 'package:flutter/material.dart';

import '../../models/cars.dart';
import 'widgets/car_features.dart';
import 'widgets/car_page_car_details.dart';
import 'widgets/custom_row.dart';
import 'widgets/image_widget.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({Key? key, required this.car}) : super(key: key);

  final Car car;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.car.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRow(
              onBackPressed: () {
                Navigator.pop(context);
              },
              onFavoritePressed: () {
                setState(() {
                  widget.car.isFavorite = !widget.car.isFavorite;
                });
              },
              isFavorite: widget.car.isFavorite,
            ),
            ImageWidget(
              size: size,
              widget: widget,
            ),
            const SizedBox(
              height: 32,
            ),
            CarPageCarDetails(size: size, car: widget.car),
            const SizedBox(height: 50),
            const CarFeatures(),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                "Model S is build for speed and range , with beyond ludicrus acceleration unparalleled performance and a sleek aesthetic.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
