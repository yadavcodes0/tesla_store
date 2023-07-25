import 'package:flutter/material.dart';

import '../../../models/cars.dart';
import 'book_now_button.dart';
import 'car_details.dart';

class CarCard extends StatefulWidget {
  const CarCard({super.key, required this.car});
  final Car car;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.45,
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        gradient: LinearGradient(
          colors: widget.car.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    widget.car.isFavorite = !widget.car.isFavorite;
                  }),
                  child: widget.car.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  widget.car.image.first,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 16,
                ),
                CarDetails(widget: widget),
              ],
            ),
          ),
          const Row(
            children: [
              Spacer(
                flex: 2,
              ),
              Text(
                "Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              Spacer(
                flex: 3,
              ),
              BookNowButton(),
            ],
          ),
        ],
      ),
    );
  }
}
