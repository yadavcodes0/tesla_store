import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tesla_store/main.dart';

void main() {
  Future<void> enterShowroom(WidgetTester tester) async {
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();
  }

  testWidgets('showroom renders premium Tesla experience', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 1800));
    await tester.pumpWidget(const MyApp());
    await enterShowroom(tester);

    expect(find.text('TESLA STORE'), findsOneWidget);
    expect(find.text('Available lineup'), findsOneWidget);
    expect(find.text('Model S'), findsWidgets);
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('full booking flow carries selection to confirmation',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1400, 1800));
    await tester.pumpWidget(const MyApp());
    await enterShowroom(tester);

    await tester.tap(find.text('View product page').first);
    await tester.pumpAndSettle();

    expect(find.text('Trim comparison'), findsOneWidget);

    await tester.tap(find.text('Open configurator'));
    await tester.pumpAndSettle();

    expect(find.text('Configurator'), findsOneWidget);
    expect(find.text('Continue to reservation'), findsOneWidget);

    await tester.tap(find.text('Continue to reservation'));
    await tester.pumpAndSettle();

    expect(find.text('Reservation summary'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Full name'),
        'Alex Mercer');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'alex@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Phone'),
      '5551234567',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'City'),
      'Bengaluru',
    );

    await tester.tap(find.text('Place reservation'));
    await tester.pumpAndSettle();

    expect(find.text('Reservation confirmed'), findsOneWidget);
    expect(find.textContaining('Alex Mercer'), findsOneWidget);
    expect(find.textContaining('Reservation code'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });
}
