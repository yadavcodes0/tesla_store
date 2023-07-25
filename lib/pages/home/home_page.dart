import 'package:flutter/material.dart';
import 'package:tesla_store/constants.dart';
import 'package:tesla_store/models/cars.dart';
import 'package:tesla_store/pages/home/widget/car_card.dart';

import '../car_details/car_details.dart';
import 'widget/horizontal_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedTabBar = "MODEL S";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 32),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [blackPrimary, blackSec],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: size.width,
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                width: size.width * 0.4,
              ),
              const SizedBox(
                height: 16,
              ),
              HorizontalTabBar(
                onTap: (p0) {
                  setState(() {
                    selectedTabBar = getSelectedTab(p0);
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: cars
                        .where((element) =>
                            element.name.toUpperCase() == selectedTabBar)
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarDetails(
                                    car: e,
                                  ),
                                ),
                              );
                            },
                            child: CarCard(
                              car: e,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getSelectedTab(int index) {
    switch (index) {
      case 0:
        return "MODEL S";
      case 1:
        return "MODEL 3";
      case 2:
        return "MODEL X";
      case 3:
        return "MODEL Y";
      default:
        return "MODEL S";
    }
  }
}
