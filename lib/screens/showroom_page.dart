import 'package:flutter/material.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/models/vehicle_model.dart';
import 'package:tesla_store/state/tesla_store_scope.dart';
import 'package:tesla_store/ui/app_theme.dart';

class ShowroomPage extends StatefulWidget {
  const ShowroomPage({super.key});

  @override
  State<ShowroomPage> createState() => _ShowroomPageState();
}

class _ShowroomPageState extends State<ShowroomPage> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final controller = TeslaStoreScope.of(context);
    final featured = controller.featuredModel();
    final categories = ['All', ...controller.categories];
    final models = controller.modelsForCategory(_selectedCategory);
    final favorites = controller.favoriteModels();
    final recents = controller.recentlyViewedModels();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth > 1200
                ? 1180.0
                : constraints.maxWidth;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShowroomHeader(favoriteCount: controller.favoriteCount),
                      const SizedBox(height: 20),
                      _HeroShowcase(
                        model: featured,
                        onTap: () {
                          controller.markRecentlyViewed(featured.id);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.details,
                            arguments: featured.id,
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categories.map((category) {
                          final selected = category == _selectedCategory;
                          return ChoiceChip(
                            label: Text(category),
                            selected: selected,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            selectedColor: Colors.white,
                            backgroundColor: AppTheme.panel,
                            labelStyle: TextStyle(
                              color: selected
                                  ? AppTheme.background
                                  : AppTheme.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Available lineup',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 14),
                      _VehicleGrid(
                        models: models,
                        onToggleFavorite: controller.toggleFavorite,
                        onOpen: (modelId) {
                          controller.markRecentlyViewed(modelId);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.details,
                            arguments: modelId,
                          );
                        },
                        isFavorite: controller.isFavorite,
                      ),
                      if (recents.isNotEmpty) ...[
                        const SizedBox(height: 28),
                        Text(
                          'Recently explored',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        _StripSection(models: recents),
                      ],
                      if (favorites.isNotEmpty) ...[
                        const SizedBox(height: 28),
                        Text(
                          'Saved favorites',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        _StripSection(models: favorites),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShowroomHeader extends StatelessWidget {
  const _ShowroomHeader({required this.favoriteCount});

  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TESLA STORE',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    letterSpacing: 4,
                    color: AppTheme.textMuted,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Build a reservation-worthy EV experience.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        );
        final badge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.panelMuted,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: Colors.white),
              const SizedBox(width: 8),
              Text('$favoriteCount saved'),
            ],
          ),
        );
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBlock,
              const SizedBox(height: 12),
              badge,
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: titleBlock),
            const SizedBox(width: 16),
            badge,
          ],
        );
      },
    );
  }
}

class _HeroShowcase extends StatelessWidget {
  const _HeroShowcase({required this.model, required this.onTap});

  final VehicleModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          colors: model.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(model.backdropImage, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontal = constraints.maxWidth > 800;
                final details = Column(
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
                      child: Text(model.category.toUpperCase()),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      model.name,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      model.headline,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      model.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textMuted,
                            height: 1.45,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _MetricPill(
                          title: '${model.trims.first.rangeMiles} mi',
                          subtitle: 'estimated range',
                        ),
                        _MetricPill(
                          title: '${model.trims.first.zeroToSixty}s',
                          subtitle: '0-60 mph',
                        ),
                        _MetricPill(
                          title: '\$${_priceLabel(model.trims.first.price)}',
                          subtitle: 'starting price',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.background,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                      ),
                      child: const Text('Explore flagship experience'),
                    ),
                  ],
                );
                final heroImage = Hero(
                  tag: 'vehicle-${model.id}',
                  child: Image.asset(
                    model.heroImage,
                    fit: BoxFit.contain,
                    height: 320,
                  ),
                );
                if (horizontal) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: details),
                      const SizedBox(width: 18),
                      Expanded(child: heroImage),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    details,
                    const SizedBox(height: 18),
                    Align(alignment: Alignment.center, child: heroImage),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleGrid extends StatelessWidget {
  const _VehicleGrid({
    required this.models,
    required this.onToggleFavorite,
    required this.onOpen,
    required this.isFavorite,
  });

  final List<VehicleModel> models;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<String> onOpen;
  final bool Function(String) isFavorite;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1050
            ? 3
            : constraints.maxWidth > 720
                ? 2
                : 1;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: models.map((model) {
            final cardWidth = (constraints.maxWidth - (16 * (columns - 1))) /
                columns;
            return SizedBox(
              width: cardWidth,
              child: _VehicleCard(
                model: model,
                isFavorite: isFavorite(model.id),
                onFavorite: () => onToggleFavorite(model.id),
                onOpen: () => onOpen(model.id),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.model,
    required this.isFavorite,
    required this.onFavorite,
    required this.onOpen,
  });

  final VehicleModel model;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final trim = model.trims.first;
    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.panel,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  model.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              model.headline,
              style: const TextStyle(color: AppTheme.textMuted, height: 1.4),
            ),
            const SizedBox(height: 16),
            Image.asset(model.heroImage, height: 150, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatBadge(label: '${trim.rangeMiles} mi range'),
                _StatBadge(label: '${trim.zeroToSixty}s 0-60'),
                _StatBadge(label: '\$${_priceLabel(trim.price)}'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Text(
                  'View product page',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StripSection extends StatelessWidget {
  const _StripSection({required this.models});

  final List<VehicleModel> models;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth < 280
            ? constraints.maxWidth
            : constraints.maxWidth < 540
                ? constraints.maxWidth
                : 240.0;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: models.map((model) {
            return Container(
              width: cardWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.panel,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Image.asset(model.heroImage, height: 54, width: 90),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          model.trims.first.name,
                          style: const TextStyle(color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.panelMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label),
    );
  }
}

String _priceLabel(int value) {
  final text = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    buffer.write(text[i]);
    final position = text.length - i - 1;
    if (position > 0 && position % 3 == 0) {
      buffer.write(',');
    }
  }
  return buffer.toString();
}
