import 'package:flutter/material.dart';

class HorizontalTabBar extends StatelessWidget {
  const HorizontalTabBar({
    super.key,
    required this.onTap,
  });
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: const EdgeInsets.only(right: 20),
      indicatorPadding: const EdgeInsets.only(right: 20),
      isScrollable: true,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      physics: const BouncingScrollPhysics(),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicator: const UnderlineTabIndicator(
        insets: EdgeInsets.symmetric(horizontal: 24),
        borderSide: BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
      tabs: ["MODEL S", "MODEL 3", "MODEL X", "MODEL Y"]
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                e,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
