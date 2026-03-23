import 'package:flutter/material.dart';
import 'package:tesla_store/models/vehicle_trim.dart';

class VehicleModel {
  const VehicleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.headline,
    required this.description,
    required this.heroImage,
    required this.backdropImage,
    required this.heroGradient,
    required this.trims,
  });

  final String id;
  final String name;
  final String category;
  final String headline;
  final String description;
  final String heroImage;
  final String backdropImage;
  final List<Color> heroGradient;
  final List<VehicleTrim> trims;
}
