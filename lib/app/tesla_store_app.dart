import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/main.dart';
import 'package:tesla_store/screens/booking_confirmation_page.dart';
import 'package:tesla_store/screens/booking_page.dart';
import 'package:tesla_store/screens/configurator_page.dart';
import 'package:tesla_store/screens/login_page.dart';
import 'package:tesla_store/screens/onboarding_page.dart';
import 'package:tesla_store/screens/showroom_page.dart';
import 'package:tesla_store/screens/signup_page.dart';
import 'package:tesla_store/screens/splash_page.dart';
import 'package:tesla_store/screens/vehicle_details_page.dart';
import 'package:tesla_store/state/tesla_store_controller.dart';
import 'package:tesla_store/state/tesla_store_scope.dart';
import 'package:tesla_store/ui/app_theme.dart';

class TeslaStoreApp extends StatefulWidget {
  const TeslaStoreApp({super.key});

  @override
  State<TeslaStoreApp> createState() => _TeslaStoreAppState();
}

class _TeslaStoreAppState extends State<TeslaStoreApp> {
  late final TeslaStoreController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TeslaStoreController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TeslaStoreScope(
      controller: _controller,
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        scrollBehavior: const TeslaScrollBehavior(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute<void>(
                builder: (_) => const SplashPage(),
                settings: settings,
              );
            case AppRoutes.onboarding:
              return MaterialPageRoute<void>(
                builder: (_) => const OnboardingPage(),
                settings: settings,
              );
            case AppRoutes.login:
              return MaterialPageRoute<void>(
                builder: (_) => const LoginPage(),
                settings: settings,
              );
            case AppRoutes.signup:
              return MaterialPageRoute<void>(
                builder: (_) => const SignUpPage(),
                settings: settings,
              );
            case AppRoutes.showroom:
              return MaterialPageRoute<void>(
                builder: (_) => const ShowroomPage(),
                settings: settings,
              );
            case AppRoutes.details:
              final modelId = settings.arguments! as String;
              return MaterialPageRoute<void>(
                builder: (_) => VehicleDetailsPage(modelId: modelId),
                settings: settings,
              );
            case AppRoutes.configurator:
              final modelId = settings.arguments! as String;
              return MaterialPageRoute<void>(
                builder: (_) => ConfiguratorPage(modelId: modelId),
                settings: settings,
              );
            case AppRoutes.booking:
              final modelId = settings.arguments! as String;
              return MaterialPageRoute<void>(
                builder: (_) => BookingPage(modelId: modelId),
                settings: settings,
              );
            case AppRoutes.confirmation:
              return MaterialPageRoute<void>(
                builder: (_) => const BookingConfirmationPage(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
