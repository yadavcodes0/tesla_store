import 'package:tesla_store/models/vehicle_color.dart';

class VehicleTrim {
  const VehicleTrim({
    required this.id,
    required this.name,
    required this.tagline,
    required this.price,
    required this.rangeMiles,
    required this.zeroToSixty,
    required this.topSpeed,
    required this.drive,
    required this.battery,
    required this.highlights,
    required this.colors,
  });

  final String id;
  final String name;
  final String tagline;
  final int price;
  final int rangeMiles;
  final double zeroToSixty;
  final int topSpeed;
  final String drive;
  final String battery;
  final List<String> highlights;
  final List<VehicleColorOption> colors;
}
