import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/presentation/widgets/rental_confirmation_dialog.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

void main() {
  group('RentalConfirmationDialog Widget Tests', () {
    late MotoEntity testMoto;

    setUp(() {
      testMoto = MotoEntity(
        id: '1',
        model: 'Honda Vision',
        fuelCapacity: 5.5,
        distance: 10.0,
        pricePerHour: 8.0,
        status: 'available',
      );
    });

    // Helper function to build dialog with proper constraints
    Widget buildTestableDialog(MotoEntity moto) {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 800,
              child: Builder(
                builder: (context) {
                  return RentalConfirmationDialog(
                    moto: moto,
                    parentContext: context,
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('should display dialog title', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Confirm Rental'), findsOneWidget);
    });

    testWidgets('should display subtitle text', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Please review the information'), findsOneWidget);
    });

    testWidgets('should display motorcycle icon', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.byIcon(Icons.two_wheeler), findsOneWidget);
    });

    testWidgets('should display moto model', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Model'), findsOneWidget);
      expect(find.text('Honda Vision'), findsOneWidget);
    });

    testWidgets('should display price per hour', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Price per Hour'), findsOneWidget);
      expect(find.text('\$8.00'), findsOneWidget);
    });

    testWidgets('should display distance', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Distance'), findsOneWidget);
      expect(find.text('10 km'), findsOneWidget);
    });

    testWidgets('should display fuel capacity', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Fuel Capacity'), findsOneWidget);
      expect(find.text('5.5 L'), findsOneWidget);
    });

    testWidgets('should display start time label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Start Time'), findsOneWidget);
    });

    testWidgets('should display all info icons', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));

      expect(find.byIcon(Icons.two_wheeler), findsOneWidget);
      expect(find.byIcon(Icons.motorcycle), findsOneWidget);
      expect(find.byIcon(Icons.attach_money), findsOneWidget);
      expect(find.byIcon(Icons.speed), findsOneWidget);
      expect(find.byIcon(Icons.local_gas_station), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('should display Cancel button', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('should display Confirm button', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should have correct dialog shape', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));

      final dialog = tester.widget<Dialog>(find.byType(Dialog));
      final shape = dialog.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, BorderRadius.circular(20));
    });

    testWidgets('should display dividers between info rows', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.byType(Divider), findsNWidgets(4));
    });

    testWidgets('should have correct text styles', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));

      final titleText = tester.widget<Text>(find.text('Confirm Rental'));
      expect(titleText.style?.fontSize, 24);
      expect(titleText.style?.fontWeight, FontWeight.bold);

      final subtitleText = tester.widget<Text>(
        find.text('Please review the information'),
      );
      expect(subtitleText.style?.fontSize, 14);
    });

    testWidgets('should have buttons with callbacks', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));

      final cancelButton = tester.widget<OutlinedButton>(
        find.byType(OutlinedButton),
      );
      expect(cancelButton.onPressed, isNotNull);

      final confirmButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(confirmButton.onPressed, isNotNull);
    });

    testWidgets('should display different moto data correctly', (WidgetTester tester) async {
      final customMoto = MotoEntity(
        id: '2',
        model: 'Yamaha Aerox',
        fuelCapacity: 7.8,
        distance: 25.3,
        pricePerHour: 12.50,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(customMoto));

      expect(find.text('Yamaha Aerox'), findsOneWidget);
      expect(find.text('\$12.50'), findsOneWidget);
      expect(find.text('25 km'), findsOneWidget);
      expect(find.text('7.8 L'), findsOneWidget);
    });

    testWidgets('should have proper spacing', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('should display Row widgets for layout', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('should format price with 2 decimal places', (WidgetTester tester) async {
      final motoWithPrice = MotoEntity(
        id: '3',
        model: 'Test Moto',
        fuelCapacity: 10.0,
        distance: 20.0,
        pricePerHour: 15.5,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(motoWithPrice));
      expect(find.text('\$15.50'), findsOneWidget);
    });

    testWidgets('should format distance without decimal', (WidgetTester tester) async {
      final motoWithDistance = MotoEntity(
        id: '4',
        model: 'Test Moto',
        fuelCapacity: 10.0,
        distance: 25.8,
        pricePerHour: 10.0,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(motoWithDistance));
      expect(find.text('26 km'), findsOneWidget);
    });

    testWidgets('should format fuel capacity with 1 decimal', (WidgetTester tester) async {
      final motoWithFuel = MotoEntity(
        id: '5',
        model: 'Test Moto',
        fuelCapacity: 8.75,
        distance: 20.0,
        pricePerHour: 10.0,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(motoWithFuel));
      expect(find.text('8.8 L'), findsOneWidget);
    });

    testWidgets('should have transparent background for Dialog', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));

      final dialog = tester.widget<Dialog>(find.byType(Dialog));
      expect(dialog.backgroundColor, Colors.transparent);
      expect(dialog.elevation, 0);
    });

    testWidgets('should display Column for main layout', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableDialog(testMoto));
      expect(find.byType(Column), findsWidgets);
    });
  });

  group('RentalConfirmationDialog Edge Cases', () {
    Widget buildTestableDialog(MotoEntity moto) {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 800,
              child: Builder(
                builder: (context) {
                  return RentalConfirmationDialog(
                    moto: moto,
                    parentContext: context,
                  );
                },
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('should handle large numbers correctly', (WidgetTester tester) async {
      final largeMoto = MotoEntity(
        id: '10',
        model: 'Large Test Moto',
        fuelCapacity: 99.9,
        distance: 999.9,
        pricePerHour: 99.99,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(largeMoto));

      expect(find.text('Large Test Moto'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
      expect(find.text('1000 km'), findsOneWidget);
      expect(find.text('99.9 L'), findsOneWidget);
    });

    testWidgets('should handle small numbers correctly', (WidgetTester tester) async {
      final smallMoto = MotoEntity(
        id: '11',
        model: 'Small Test Moto',
        fuelCapacity: 1.2,
        distance: 2.5,
        pricePerHour: 1.50,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(smallMoto));

      expect(find.text('Small Test Moto'), findsOneWidget);
      expect(find.text('\$1.50'), findsOneWidget);
      expect(find.text('3 km'), findsOneWidget);
      expect(find.text('1.2 L'), findsOneWidget);
    });

    testWidgets('should handle long model names', (WidgetTester tester) async {
      final longNameMoto = MotoEntity(
        id: '12',
        model: 'Kawasaki Ninja ZX-10R SuperSport Edition',
        fuelCapacity: 17.0,
        distance: 30.0,
        pricePerHour: 25.0,
        status: 'available',
      );

      await tester.pumpWidget(buildTestableDialog(longNameMoto));
      expect(find.text('Kawasaki Ninja ZX-10R SuperSport Edition'), findsOneWidget);
    });
  });

  group('RentalConfirmationDialog Button Interactions', () {
    testWidgets('should have tappable Cancel button', (WidgetTester tester) async {
      final testMoto = MotoEntity(
        id: '1',
        model: 'Honda Vision',
        fuelCapacity: 5.5,
        distance: 10.0,
        pricePerHour: 8.0,
        status: 'available',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 800,
                child: Builder(
                  builder: (context) {
                    return RentalConfirmationDialog(
                      moto: testMoto,
                      parentContext: context,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Verify Cancel button exists and is tappable
      final cancelButton = find.text('Cancel');
      expect(cancelButton, findsOneWidget);

      final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('should have tappable Confirm button', (WidgetTester tester) async {
      final testMoto = MotoEntity(
        id: '1',
        model: 'Honda Vision',
        fuelCapacity: 5.5,
        distance: 10.0,
        pricePerHour: 8.0,
        status: 'available',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 800,
                child: Builder(
                  builder: (context) {
                    return RentalConfirmationDialog(
                      moto: testMoto,
                      parentContext: context,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Verify Confirm button exists and is tappable
      final confirmButton = find.text('Confirm');
      expect(confirmButton, findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });
  });
}