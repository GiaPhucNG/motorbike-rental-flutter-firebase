import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/data/models/moto_model.dart';
import 'package:rentapp/presentation/widgets/more_card.dart'; // Correct import path

void main() {
  // Sample Moto object for testing
  final testMoto = Moto(
    model: 'Honda CBR',
    distance: 120.5,
    fuelCapacity: 15.0,
    pricePerHour: 10.0,
    status: 'available', // Adjust if status is a different type
  );

  group('MoreCard Widget Tests', () {
    testWidgets('MoreCard renders correctly with Moto data', (WidgetTester tester) async {
      // Arrange: Build the MoreCard widget with the test Moto object
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoreCard(moto: testMoto),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check if the Moto model text is displayed
      expect(find.text('Honda CBR'), findsOneWidget);

      // Assert: Check if the distance text is displayed
      expect(find.text('> 120.5 km'), findsOneWidget);

      // Assert: Check if the fuel capacity text is displayed
      expect(find.text('15.0'), findsOneWidget);

      // Assert: Check if the icons are present
      expect(find.byIcon(Icons.directions_bike), findsOneWidget);
      expect(find.byIcon(Icons.battery_full), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('MoreCard has correct styling', (WidgetTester tester) async {
      // Arrange: Build the MoreCard widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoreCard(moto: testMoto),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Find the Container widget and check its decoration
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final containerWidget = tester.widget<Container>(containerFinder);
      final boxDecoration = containerWidget.decoration as BoxDecoration;

      // Assert: Check background color
      expect(boxDecoration.color, Colors.green);

      // Assert: Check border radius
      expect(boxDecoration.borderRadius, BorderRadius.circular(18));

      // Assert: Check box shadow
      expect(boxDecoration.boxShadow, isNotEmpty);
      expect(boxDecoration.boxShadow!.first.color, Colors.black54);
      expect(boxDecoration.boxShadow!.first.blurRadius, 8);
      expect(boxDecoration.boxShadow!.first.offset, Offset(0, 4));
    });

    testWidgets('MoreCard layout is correct', (WidgetTester tester) async {
      // Arrange: Build the MoreCard widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MoreCard(moto: testMoto),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check if the top-level Row with spaceBetween alignment is used
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Row &&
              widget.mainAxisAlignment == MainAxisAlignment.spaceBetween,
        ),
        findsOneWidget,
      );

      // Assert: Check if Column is used for text and icons
      expect(find.byType(Column), findsOneWidget);

      // Assert: Check if padding is applied
      final containerFinder = find.byType(Container);
      final containerWidget = tester.widget<Container>(containerFinder);
      expect(containerWidget.padding, EdgeInsets.all(10));
    });
  });
}