import 'package:flutter/material.dart';

import '../constants.dart';

class Car {
  final String name;
  final String type;
  final List<String> image;
  final String price;
  final String description;
  final List<Color> colors;
  bool isFavorite;

  Car({
    required this.name,
    required this.image,
    required this.colors,
    required this.price,
    required this.type,
    required this.description,
    this.isFavorite = false,
  });
}

List<Car> cars = [
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model S",
      type: "Ludicrous Mode",
      price: "\$99,000",
      description:
          "Model S is built for speed and range, with beyond ludicrous acceleration, unparalleled performance, and a sleek aesthetic.",
      image: ["assets/models1.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model S",
      type: "Performance",
      price: "\$99,000",
      description:
          "Model S Performance is designed for maximum speed and agility, delivering an unforgettable driving experience.",
      image: ["assets/models2.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model 3",
      type: "Ludicrous Mode",
      price: "\$46,990",
      description:
          "Model 3 Ludicrous brings track-ready performance to the masses in a beautifully sculpted and efficient package.",
      image: ["assets/model31.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model 3",
      type: "Performance",
      price: "\$46,990",
      description:
          "Model 3 Performance features dual motor all-wheel drive, upgraded brakes, and lowered suspension for total control.",
      image: ["assets/model32.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [bluePrimary, blueSec],
      name: "Model X",
      type: "Performance",
      price: "\$112,590",
      description:
          "Model X Performance combines the utility of an SUV with the performance of a sports car.",
      image: ["assets/modelx2.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model X",
      type: "Ludicrous Mode",
      price: "\$112,590",
      description:
          "Model X Ludicrous takes the family SUV to new heights with mind-bending acceleration and distinctive falcon-wing doors.",
      image: ["assets/modelx1.png", "assets/grey1.png", "assets/grey2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model Y",
      type: "Ludicrous Mode",
      price: "\$58,190",
      description:
          "Model Y Ludicrous is the ultimate mid-size SUV, offering exceptional range, performance, and versatility.",
      image: ["assets/modely1.png", "assets/blue1.png", "assets/blue2.png"]),
  Car(
      colors: [blackSec, blackPrimary],
      name: "Model Y",
      type: "Performance",
      price: "\$58,190",
      description:
          "Model Y Performance provides thrilling track-inspired performance with everyday utility and comfort.",
      image: ["assets/modely2.png", "assets/blue1.png", "assets/blue2.png"]),
];
