import 'package:flutter/material.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/ui/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _index = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      eyebrow: 'DISCOVER',
      title: 'Browse the fleet like a private launch event.',
      description:
          'Each model is presented with cinematic detail, tight specs, and a premium first impression.',
      image: 'assets/models1.png',
      stats: ['405 mi range', '3.1s 0-60', 'Premium cockpit'],
      gradient: [Color(0xFF0C1120), Color(0xFF233F82)],
    ),
    _OnboardingItem(
      eyebrow: 'CONFIGURE',
      title: 'Tune trims and paint with instant feedback.',
      description:
          'Switch between performance setups and colorways without losing the mobile flow.',
      image: 'assets/model31.png',
      stats: ['Live trim selection', 'Color preview', 'Reservation-ready'],
      gradient: [Color(0xFF111522), Color(0xFF2C344B)],
    ),
    _OnboardingItem(
      eyebrow: 'RESERVE',
      title: 'Move from desire to reservation in minutes.',
      description:
          'A cleaner booking path keeps momentum high and makes the app feel production-grade.',
      image: 'assets/modely1.png',
      stats: ['Fast entry', 'Clean checkout', 'Instant confirmation'],
      gradient: [Color(0xFF101521), Color(0xFF32557E)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _items.length - 1;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF06080D), Color(0xFF0A1020)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'TESLA STORE',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 4,
                            color: Colors.white60,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                      child: const Text('Skip'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (value) {
                    setState(() {
                      _index = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          gradient: LinearGradient(
                            colors: item.gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -70,
                              top: -30,
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0x333A68FF),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(item.eyebrow),
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          height: 1.05,
                                        ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      color: AppTheme.textMuted,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: item.stats
                                        .map((stat) => _OnboardingChip(label: stat))
                                        .toList(),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Image.asset(
                                      item.image,
                                      height: 250,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(
                        _items.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          width: _index == i ? 26 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _index == i ? Colors.white : Colors.white24,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        if (isLast) {
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                          return;
                        }
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.background,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 16,
                        ),
                      ),
                      child: Text(isLast ? 'Get started' : 'Next'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  const _OnboardingItem({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.image,
    required this.stats,
    required this.gradient,
  });

  final String eyebrow;
  final String title;
  final String description;
  final String image;
  final List<String> stats;
  final List<Color> gradient;
}

class _OnboardingChip extends StatelessWidget {
  const _OnboardingChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(label),
    );
  }
}
