import 'package:flutter/material.dart';
import 'package:tesla_store/models/vehicle_color.dart';
import 'package:tesla_store/models/vehicle_model.dart';
import 'package:tesla_store/models/vehicle_trim.dart';

class TeslaRepository {
  const TeslaRepository();

  List<VehicleModel> getModels() {
    const blue = VehicleColorOption(
      id: 'deep-blue',
      name: 'Deep Blue Metallic',
      swatch: Color(0xFF2C5BFF),
      showcaseImage: 'assets/blue1.png',
      gallery: ['assets/blue1.png', 'assets/blue2.png'],
    );
    const stealth = VehicleColorOption(
      id: 'stealth-black',
      name: 'Stealth Black',
      swatch: Color(0xFF16171A),
      showcaseImage: 'assets/grey1.png',
      gallery: ['assets/grey1.png', 'assets/grey2.png'],
    );
    const pearl = VehicleColorOption(
      id: 'pearl-white',
      name: 'Pearl White Multi-Coat',
      swatch: Color(0xFFE6E8ED),
      showcaseImage: 'assets/blue2.png',
      gallery: ['assets/blue2.png', 'assets/models1.png'],
    );

    return const [
      VehicleModel(
        id: 'model-s',
        name: 'Model S',
        category: 'Sedan',
        headline: 'Executive acceleration with cinematic presence.',
        description:
            'A flagship performance sedan with sweeping range, premium cockpit comfort, and a focused high-speed character.',
        heroImage: 'assets/models1.png',
        backdropImage: 'assets/road.jpg',
        heroGradient: [Color(0xFF10151D), Color(0xFF233B78)],
        trims: [
          VehicleTrim(
            id: 'model-s-awd',
            name: 'Dual Motor AWD',
            tagline: 'Long-range confidence with quiet brutality.',
            price: 94990,
            rangeMiles: 405,
            zeroToSixty: 3.1,
            topSpeed: 149,
            drive: 'Dual Motor AWD',
            battery: '100 kWh performance pack',
            highlights: [
              '405 mi EPA est. range',
              '17" cinematic display',
              'Adaptive air suspension',
            ],
            colors: [blue, pearl, stealth],
          ),
          VehicleTrim(
            id: 'model-s-plaid',
            name: 'Plaid',
            tagline: 'Hypercar energy tuned for everyday roads.',
            price: 109990,
            rangeMiles: 359,
            zeroToSixty: 1.99,
            topSpeed: 200,
            drive: 'Tri Motor AWD',
            battery: 'Track-ready thermal pack',
            highlights: [
              '1,020 hp equivalent output',
              'Track mode with torque vectoring',
              'Carbon fiber decor',
            ],
            colors: [stealth, blue, pearl],
          ),
        ],
      ),
      VehicleModel(
        id: 'model-3',
        name: 'Model 3',
        category: 'Sedan',
        headline: 'Minimal design, maximal momentum.',
        description:
            'A focused electric sports sedan that mixes accessible pricing with sharp performance and a calm cabin.',
        heroImage: 'assets/model31.png',
        backdropImage: 'assets/road.jpg',
        heroGradient: [Color(0xFF0F1114), Color(0xFF4C5664)],
        trims: [
          VehicleTrim(
            id: 'model-3-long-range',
            name: 'Long Range',
            tagline: 'The everyday performance benchmark.',
            price: 46990,
            rangeMiles: 341,
            zeroToSixty: 4.2,
            topSpeed: 125,
            drive: 'Dual Motor AWD',
            battery: 'Long-range pack',
            highlights: [
              'Fast charging road-trip setup',
              'Panoramic glass roof',
              'Premium 17-speaker audio',
            ],
            colors: [blue, stealth, pearl],
          ),
          VehicleTrim(
            id: 'model-3-performance',
            name: 'Performance',
            tagline: 'A sharper, lower, faster sport configuration.',
            price: 53990,
            rangeMiles: 303,
            zeroToSixty: 2.9,
            topSpeed: 163,
            drive: 'Dual Motor AWD',
            battery: 'Performance-tuned pack',
            highlights: [
              'Track package ready',
              'Performance brakes',
              'Sport seats and lowered stance',
            ],
            colors: [pearl, blue, stealth],
          ),
        ],
      ),
      VehicleModel(
        id: 'model-x',
        name: 'Model X',
        category: 'SUV',
        headline: 'Family-scale space with supercar shock value.',
        description:
            'A high-capability electric SUV with dramatic proportions, premium packaging, and distinctive road presence.',
        heroImage: 'assets/modelx1.png',
        backdropImage: 'assets/road.jpg',
        heroGradient: [Color(0xFF0D1016), Color(0xFF385C8A)],
        trims: [
          VehicleTrim(
            id: 'model-x-awd',
            name: 'Dual Motor AWD',
            tagline: 'The luxury utility flagship.',
            price: 104990,
            rangeMiles: 335,
            zeroToSixty: 3.8,
            topSpeed: 149,
            drive: 'Dual Motor AWD',
            battery: 'Long-range SUV pack',
            highlights: [
              'Falcon wing rear access',
              'Seating for up to 7',
              'Front windshield panorama',
            ],
            colors: [stealth, blue, pearl],
          ),
          VehicleTrim(
            id: 'model-x-plaid',
            name: 'Plaid',
            tagline: 'Three-motor violence in an ultra-premium SUV.',
            price: 119990,
            rangeMiles: 326,
            zeroToSixty: 2.5,
            topSpeed: 163,
            drive: 'Tri Motor AWD',
            battery: 'Plaid thermal system',
            highlights: [
              'Three-motor drivetrain',
              'Yoke steering option',
              'Premium second-row comfort',
            ],
            colors: [blue, stealth, pearl],
          ),
        ],
      ),
      VehicleModel(
        id: 'model-y',
        name: 'Model Y',
        category: 'SUV',
        headline: 'The daily-driver sweet spot with elevated pace.',
        description:
            'A compact electric SUV with broad usability, quick charging, confident all-weather capability, and high perceived value.',
        heroImage: 'assets/modely1.png',
        backdropImage: 'assets/road.jpg',
        heroGradient: [Color(0xFF10131C), Color(0xFF2A3242)],
        trims: [
          VehicleTrim(
            id: 'model-y-long-range',
            name: 'Long Range',
            tagline: 'Balanced range, utility, and confident speed.',
            price: 52190,
            rangeMiles: 330,
            zeroToSixty: 4.8,
            topSpeed: 135,
            drive: 'Dual Motor AWD',
            battery: 'Utility-focused pack',
            highlights: [
              'Flat-fold storage flexibility',
              'All-glass roof',
              'Confidence in all-weather traction',
            ],
            colors: [pearl, blue, stealth],
          ),
          VehicleTrim(
            id: 'model-y-performance',
            name: 'Performance',
            tagline: 'Track-inspired energy in the most practical body.',
            price: 58190,
            rangeMiles: 285,
            zeroToSixty: 3.5,
            topSpeed: 155,
            drive: 'Dual Motor AWD',
            battery: 'Performance cooling pack',
            highlights: [
              'Performance brakes and pedals',
              'Lowered suspension tune',
              'Rapid family-hauler acceleration',
            ],
            colors: [blue, stealth, pearl],
          ),
        ],
      ),
    ];
  }
}
