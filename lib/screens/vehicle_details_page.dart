import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/models/vehicle_trim.dart';
import 'package:tesla_store/state/tesla_store_scope.dart';
import 'package:tesla_store/ui/app_theme.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({super.key, required this.modelId});

  final String modelId;

  @override
  Widget build(BuildContext context) {
    final controller = TeslaStoreScope.of(context);
    final model = controller.getModel(modelId);
    final trim = controller.selectedTrimFor(modelId);
    final color = controller.selectedColorFor(modelId);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.panelMuted,
                          foregroundColor: AppTheme.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          controller.toggleFavorite(model.id);
                        },
                        child: Text(
                          controller.isFavorite(model.id)
                              ? 'Saved'
                              : 'Save favorite',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: model.heroGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final horizontal = constraints.maxWidth > 860;
                        final compact = !horizontal;
                        final details = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.headline,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              model.description,
                              style: const TextStyle(
                                color: AppTheme.textMuted,
                                height: 1.5,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: compact ? 14 : 22),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _HighlightCard(
                                  title: '${trim.rangeMiles} mi',
                                  subtitle: 'estimated range',
                                ),
                                _HighlightCard(
                                  title: '${trim.zeroToSixty}s',
                                  subtitle: '0-60 mph',
                                ),
                                _HighlightCard(
                                  title: '${trim.topSpeed} mph',
                                  subtitle: 'top speed',
                                ),
                              ],
                            ),
                            SizedBox(height: compact ? 14 : 22),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: trim.highlights
                                  .map((item) => _FeatureChip(label: item))
                                  .toList(),
                            ),
                            SizedBox(height: compact ? 16 : 26),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    controller.markRecentlyViewed(model.id);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.configurator,
                                      arguments: model.id,
                                    );
                                  },
                                  child: const Text('Open configurator'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    controller.startBooking(model.id);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.booking,
                                      arguments: model.id,
                                    );
                                  },
                                  child: const Text('Reserve now'),
                                ),
                              ],
                            ),
                          ],
                        );
                        final gallery = Column(
                          children: [
                            Hero(
                              tag: 'vehicle-${model.id}',
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 450),
                                child: Image.asset(
                                  color.showcaseImage,
                                  key: ValueKey(color.id),
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Wrap(
                              spacing: 10,
                              children: trim.colors.map((item) {
                                final selected = item.id == color.id;
                                return GestureDetector(
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    controller.selectColor(
                                      model.id,
                                      item.id,
                                    );
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: item.swatch,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: selected
                                            ? Colors.white
                                            : Colors.white24,
                                        width: selected ? 3 : 1,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                            Text(color.name),
                          ],
                        );
                        if (horizontal) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: details),
                              const SizedBox(width: 24),
                              Expanded(child: gallery),
                            ],
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            details,
                            const SizedBox(height: 24),
                            gallery,
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Trim comparison',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, trimConstraints) {
                      final trimCardWidth = trimConstraints.maxWidth < 380
                          ? trimConstraints.maxWidth
                          : 360.0;
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: model.trims.map((item) {
                          return SizedBox(
                            width: trimCardWidth,
                            child: _TrimCard(
                              trim: item,
                              selected: item.id == trim.id,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                controller.selectTrim(model.id, item.id);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: color.gallery.map((asset) {
                      return Container(
                        width: 220,
                        height: 140,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.panel,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset(asset, fit: BoxFit.contain),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(
            color: AppTheme.panel,
            border: Border(top: BorderSide(color: Colors.white12)),
          ),
          child: Row(
            children: [
              Text(
                '\$${_formatPrice(trim.price)}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 10),
              Text(
                trim.name,
                style: const TextStyle(color: AppTheme.textMuted),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  controller.startBooking(model.id);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.booking,
                    arguments: model.id,
                  );
                },
                child: const Text('Reserve this build'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrimCard extends StatelessWidget {
  const _TrimCard({
    required this.trim,
    required this.selected,
    required this.onTap,
  });

  final VehicleTrim trim;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppTheme.panel,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trim.name,
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              trim.tagline,
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              '\$${_formatPrice(trim.price)}',
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            _TrimRow(label: 'Drive', value: trim.drive, selected: selected),
            _TrimRow(label: 'Battery', value: trim.battery, selected: selected),
          ],
        ),
      ),
    );
  }
}

class _TrimRow extends StatelessWidget {
  const _TrimRow({
    required this.label,
    required this.value,
    required this.selected,
  });

  final String label;
  final String value;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppTheme.background : AppTheme.textMuted;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label, style: TextStyle(color: color))),
          Expanded(child: Text(value, style: TextStyle(color: color))),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label),
    );
  }
}

String _formatPrice(int value) {
  final chars = value.toString().split('');
  final buffer = StringBuffer();
  for (var i = 0; i < chars.length; i++) {
    buffer.write(chars[i]);
    final remaining = chars.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write(',');
    }
  }
  return buffer.toString();
}
