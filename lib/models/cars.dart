import 'package:flutter/material.dart';

import '../constants.dart';

class Car {
  final String name;
  final String type;
  final List<String> image;
  final String price;
  final List<Color> colors;
  bool isFavorite;

  Car({
    required this.name,
    required this.image,
    required this.colors,
    required this.price,
    required this.type,
    this.isFavorite = false,
  });
}

List<Car> cars = [
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model S",
      type: "Ludicrous Mode",
      price: "\$99,000",
      image: ["assets/models1.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model S",
      type: "Performance",
      price: "\$99,000",
      image: ["assets/models2.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model 3",
      type: "Ludicrous Mode",
      price: "\$46,990",
      image: ["assets/model31.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model 3",
      type: "Performance",
      price: "\$461990",
      image: ["assets/model32.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model X",
      type: "Performance",
      price: "\$112,590",
      image: ["assets/modelx2.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model X",
      type: "Ludicrous Mode",
      price: "\$112,590",
      image: ["assets/modelx1.png", "assets/grey1.png", "assets/grey2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model Y",
      type: "Ludicrous Mode",
      price: "\$58,190",
      image: ["assets/modely1.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model Y",
      type: "Performance",
      price: "\$58,190",
      image: ["assets/modely2.png", "assets/blue1.png", "assets/blue2.png"]),
];
