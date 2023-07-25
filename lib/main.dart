import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesla_store/pages/home/home_page.dart';

void main() {
  runApp(
    const AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tesla Store',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
