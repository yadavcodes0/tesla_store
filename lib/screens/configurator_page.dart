import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/models/vehicle_trim.dart';
import 'package:tesla_store/state/tesla_store_scope.dart';
import 'package:tesla_store/ui/app_theme.dart';

class ConfiguratorPage extends StatelessWidget {
  const ConfiguratorPage({super.key, required this.modelId});

  final String modelId;

  @override
  Widget build(BuildContext context) {
    final controller = TeslaStoreScope.of(context);
    final model = controller.getModel(modelId);
    final trim = controller.selectedTrimFor(modelId);
    final color = controller.selectedColorFor(modelId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurator'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontal = constraints.maxWidth > 880;
                final controls = Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.panel,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Build your ${model.name}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Choose the trim, lock the paint, and shape a premium reservation flow that feels real.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textMuted,
                            ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Powertrain',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, trimConstraints) {
                          if (horizontal) {
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: model.trims
                                  .map(
                                    (item) => _PowertrainCard(
                                      item: item,
                                      selected: item.id == trim.id,
                                      width: 250,
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        controller.selectTrim(
                                          model.id,
                                          item.id,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                          return Column(
                            children: model.trims
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _PowertrainCard(
                                      item: item,
                                      selected: item.id == trim.id,
                                      width: trimConstraints.maxWidth,
                                      onTap: () {
                                        HapticFeedback.selectionClick();
                                        controller.selectTrim(
                                          model.id,
                                          item.id,
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Paint',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: trim.colors.map((option) {
                          final selected = option.id == color.id;
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              controller.selectColor(model.id, option.id);
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.panelMuted,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selected
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: option.swatch,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    option.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'What this build unlocks',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      ...trim.highlights.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 18),
                              const SizedBox(width: 10),
                              Expanded(child: Text(item)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                final summary = Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.panel,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Image.asset(
                          color.showcaseImage,
                          key: ValueKey('${trim.id}-${color.id}'),
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Current build',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 14),
                      _SummaryRow(label: 'Model', value: model.name),
                      _SummaryRow(label: 'Trim', value: trim.name),
                      _SummaryRow(label: 'Color', value: color.name),
                      _SummaryRow(label: 'Range', value: '${trim.rangeMiles} mi'),
                      _SummaryRow(
                        label: '0-60 mph',
                        value: '${trim.zeroToSixty}s',
                      ),
                      _SummaryRow(
                        label: 'Top speed',
                        value: '${trim.topSpeed} mph',
                      ),
                      const Divider(height: 32, color: Colors.white12),
                      Text(
                        '\$${_formatPrice(trim.price)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Destination, taxes, and incentives are mocked for this concept build.',
                        style: TextStyle(color: AppTheme.textMuted),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {
                          controller.startBooking(model.id);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.booking,
                            arguments: model.id,
                          );
                        },
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: const Text('Continue to reservation'),
                      ),
                    ],
                  ),
                );
                if (horizontal) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: controls),
                      const SizedBox(width: 18),
                      Expanded(flex: 4, child: summary),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controls,
                    const SizedBox(height: 18),
                    summary,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PowertrainCard extends StatelessWidget {
  const _PowertrainCard({
    required this.item,
    required this.selected,
    required this.width,
    required this.onTap,
  });

  final VehicleTrim item;
  final bool selected;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppTheme.panelMuted,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.tagline,
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${_formatPrice(item.price)}',
              style: TextStyle(
                color: selected ? AppTheme.background : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: AppTheme.textMuted)),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatPrice(int value) {
  final input = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < input.length; i++) {
    buffer.write(input[i]);
    final remaining = input.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write(',');
    }
  }
  return buffer.toString();
}
