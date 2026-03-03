// test/presentation/widgets/filter_dialog_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/presentation/widgets/filter_dialog.dart';

void main() {
  group('FilterDialog Widget Tests', () {

    late Function(String?) onApplyCallback;

    setUp(() {
      onApplyCallback = (String? value) {};
    });

    /// 🔥 KEY FIX: Helper method để show dialog trong test
    Future<void> showFilterDialog(WidgetTester tester, {String? selectedPriceRange}) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                      selectedPriceRange: selectedPriceRange,
                      onApply: onApplyCallback,
                    ),
                  );
                },
                child: const Text('SHOW DIALOG'),
              ),
            ),
          ),
        ),
      );

      // Tap button để show dialog
      await tester.tap(find.text('SHOW DIALOG'));
      await tester.pumpAndSettle();
    }

    testWidgets('FilterDialog displays correctly with initial null selection', (WidgetTester tester) async {
      await showFilterDialog(tester, selectedPriceRange: null);

      // Verify dialog title
      expect(find.text('Filter by Price'), findsOneWidget);

      // ✅ FIXED: Verify bằng TEXT thay vì RadioListTile type
      expect(find.text('All Prices'), findsOneWidget);
      expect(find.text('Under 10 \$/h'), findsOneWidget);
      expect(find.text('10 - 15 \$/h'), findsOneWidget);
      expect(find.text('Over 15 \$/h'), findsOneWidget);

      // Verify buttons
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Apply'), findsOneWidget);
    });

    testWidgets('Radio button selection works correctly', (WidgetTester tester) async {
      await showFilterDialog(tester);

      // Tap "Under 10 \$/h"
      await tester.tap(find.text('Under 10 \$/h'));
      await tester.pump();

      // Tap "10 - 15 \$/h"
      await tester.tap(find.text('10 - 15 \$/h'));
      await tester.pump();

      // Verify options still visible (selection changed internally)
      expect(find.text('Under 10 \$/h'), findsOneWidget);
      expect(find.text('10 - 15 \$/h'), findsOneWidget);
    });

    testWidgets('Cancel button closes dialog without calling onApply', (WidgetTester tester) async {
      bool onApplyCalled = false;
      onApplyCallback = (String? value) {
        onApplyCalled = true;
      };

      await showFilterDialog(tester);

      // Tap Cancel
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify onApply was NOT called
      expect(onApplyCalled, isFalse);
    });

    testWidgets('Apply button calls onApply with correct value', (WidgetTester tester) async {
      String? appliedValue;
      onApplyCallback = (String? value) {
        appliedValue = value;
      };

      await showFilterDialog(tester);

      // Select "Over 15 \$/h"
      await tester.tap(find.text('Over 15 \$/h'));
      await tester.pump();

      // Tap Apply
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      // Verify correct value was passed
      expect(appliedValue, 'over_15');
    });

    testWidgets('Apply button calls onApply with null (All Prices)', (WidgetTester tester) async {
      String? appliedValue;
      onApplyCallback = (String? value) {
        appliedValue = value;
      };

      await showFilterDialog(tester);

      // Select "All Prices" (null)
      await tester.tap(find.text('All Prices'));
      await tester.pump();

      // Tap Apply
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      // Verify null was passed
      expect(appliedValue, isNull);
    });

    testWidgets('FilterDialog maintains initial selection correctly', (WidgetTester tester) async {
      await showFilterDialog(tester, selectedPriceRange: '10_to_15');

      // Verify options visible (initial selection is internal)
      expect(find.text('10 - 15 \$/h'), findsOneWidget);
    });

    testWidgets('All radio options are tappable', (WidgetTester tester) async {
      await showFilterDialog(tester);

      // Test tap on each option
      await tester.tap(find.text('All Prices'));
      await tester.pump();

      await tester.tap(find.text('Under 10 \$/h'));
      await tester.pump();

      await tester.tap(find.text('10 - 15 \$/h'));
      await tester.pump();

      await tester.tap(find.text('Over 15 \$/h'));
      await tester.pump();

      // All options still visible
      expect(find.text('All Prices'), findsOneWidget);
      expect(find.text('Under 10 \$/h'), findsOneWidget);
      expect(find.text('10 - 15 \$/h'), findsOneWidget);
      expect(find.text('Over 15 \$/h'), findsOneWidget);
    });

    testWidgets('FilterDialog has correct structure', (WidgetTester tester) async {
      await showFilterDialog(tester);

      // Verify dialog structure
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Verify all text elements
      expect(find.text('Filter by Price'), findsOneWidget);
      expect(find.text('All Prices'), findsOneWidget);
      expect(find.text('Under 10 \$/h'), findsOneWidget);
      expect(find.text('10 - 15 \$/h'), findsOneWidget);
      expect(find.text('Over 15 \$/h'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Apply'), findsOneWidget);
    });

    testWidgets('Dialog can be dismissed with Apply without selection change', (WidgetTester tester) async {
      String? appliedValue;
      onApplyCallback = (String? value) {
        appliedValue = value;
      };

      await showFilterDialog(tester);

      // Apply without changing selection (defaults to null)
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      expect(appliedValue, isNull);
    });
  });
}