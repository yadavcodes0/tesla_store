import 'package:flutter/material.dart';
import 'package:tesla_store/app/routes.dart';
import 'package:tesla_store/state/tesla_store_scope.dart';
import 'package:tesla_store/ui/app_theme.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.modelId});

  final String modelId;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TeslaStoreScope.of(context);
    final model = controller.getModel(widget.modelId);
    final trim = controller.selectedTrimFor(widget.modelId);
    final color = controller.selectedColorFor(widget.modelId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve your Tesla'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontal = constraints.maxWidth > 850;
                final summary = Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.panel,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reservation summary',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        color.showcaseImage,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      _SummaryRow(label: 'Model', value: model.name),
                      _SummaryRow(label: 'Trim', value: trim.name),
                      _SummaryRow(label: 'Color', value: color.name),
                      _SummaryRow(
                        label: 'Range',
                        value: '${trim.rangeMiles} mi',
                      ),
                      const _SummaryRow(label: 'Deposit', value: '\$250'),
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
                        'Remaining balance and incentives are presented as a demo concept.',
                        style: TextStyle(color: AppTheme.textMuted),
                      ),
                    ],
                  ),
                );
                final form = Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.panel,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer details',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Full name'),
                          validator: (value) => _required(value, 'name'),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone'),
                          validator: (value) => _required(value, 'phone'),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(labelText: 'City'),
                          validator: (value) => _required(value, 'city'),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.panelMuted,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mocked checkout',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'This concept simulates a refundable reservation deposit and instant delivery pipeline preview.',
                                style: TextStyle(color: AppTheme.textMuted),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            controller.updateBookingDetails(
                              customerName: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              city: _cityController.text.trim(),
                            );
                            controller.completeBooking();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.confirmation,
                            );
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                          child: const Text('Place reservation'),
                        ),
                      ],
                    ),
                  ),
                );
                if (horizontal) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: summary),
                      const SizedBox(width: 18),
                      Expanded(flex: 5, child: form),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    summary,
                    const SizedBox(height: 18),
                    form,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your $label';
    }
    return null;
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
            width: 90,
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
