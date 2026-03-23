import 'package:flutter/material.dart';

class VehicleColorOption {
  const VehicleColorOption({
    required this.id,
    required this.name,
    required this.swatch,
    required this.showcaseImage,
    this.gallery = const [],
  });

  final String id;
  final String name;
  final Color swatch;
  final String showcaseImage;
  final List<String> gallery;
}
