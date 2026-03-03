import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/presentation/widgets/moto_card.dart';
import 'package:rentapp/presentation/pages/moto_details_page.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

void main() {
  group('MotoCard Widget Tests', () {
    testWidgets('should display moto model name', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '1',
        model: 'Honda Vision',
        fuelCapacity: 5.5,
        distance: 10.0,
        pricePerHour: 8.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text('Honda Vision'), findsNWidgets(2)); // Model hiển thị 2 lần
    });

    testWidgets('should display available status in green', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '1',
        model: 'Honda Vision',
        fuelCapacity: 5.5,
        distance: 10.0,
        pricePerHour: 8.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text('Status: AVAILABLE'), findsOneWidget);

      final statusText = tester.widget<Text>(find.text('Status: AVAILABLE'));
      expect(statusText.style?.color, Colors.green);
    });

    testWidgets('should display rented status in red', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '2',
        model: 'Yamaha Aerox',
        fuelCapacity: 7.0,
        distance: 20.0,
        pricePerHour: 12.0,
        status: 'rented',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text('Status: RENTED'), findsOneWidget);

      final statusText = tester.widget<Text>(find.text('Status: RENTED'));
      expect(statusText.style?.color, Colors.red);
    });

    testWidgets('should display distance without decimal', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '3',
        model: 'Honda PCX',
        fuelCapacity: 8.0,
        distance: 15.7,
        pricePerHour: 10.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text(' 16km'), findsOneWidget); // Làm tròn 15.7 = 16
    });

    testWidgets('should display fuel capacity without decimal', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '4',
        model: 'Vespa Sprint',
        fuelCapacity: 7.8,
        distance: 12.0,
        pricePerHour: 10.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text(' 8L'), findsOneWidget); // Làm tròn 7.8 = 8
    });

    testWidgets('should display price per hour with 2 decimals', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '5',
        model: 'Suzuki Gixxer',
        fuelCapacity: 12.0,
        distance: 30.0,
        pricePerHour: 14.5,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text('\$14.50/h'), findsOneWidget);
    });

    testWidgets('should display moto image', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '6',
        model: 'Kawasaki Ninja',
        fuelCapacity: 17.0,
        distance: 25.0,
        pricePerHour: 18.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsNWidgets(3)); // 1 moto image + 2 icon images (gps, pump)
    });

    testWidgets('should have correct container decoration', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '7',
        model: 'Yamaha MT-03',
        fuelCapacity: 14.0,
        distance: 25.0,
        pricePerHour: 15.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xffF3F3F3));
      expect(decoration.borderRadius, BorderRadius.circular(20));
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.length, 1);
    });

    testWidgets('should be tappable with GestureDetector', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '8',
        model: 'Suzuki Hayabusa',
        fuelCapacity: 21.0,
        distance: 40.0,
        pricePerHour: 20.0,
        status: 'available',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert - Check GestureDetector exists
      expect(find.byType(GestureDetector), findsOneWidget);

      final gestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(gestureDetector.onTap, isNotNull);
    });

    testWidgets('should display all info in correct layout', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '9',
        model: 'Kawasaki Z900',
        fuelCapacity: 17.0,
        distance: 35.0,
        pricePerHour: 22.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert - Check all elements exist
      expect(find.text('Kawasaki Z900'), findsNWidgets(2));
      expect(find.text('Status: AVAILABLE'), findsOneWidget);
      expect(find.text(' 35km'), findsOneWidget);
      expect(find.text(' 17L'), findsOneWidget);
      expect(find.text('\$22.00/h'), findsOneWidget);
    });

    testWidgets('should have correct text styles', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '10',
        model: 'Vespa GTS 300',
        fuelCapacity: 9.0,
        distance: 18.0,
        pricePerHour: 13.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert - Check model text style
      final modelTexts = tester.widgetList<Text>(find.text('Vespa GTS 300'));
      for (var text in modelTexts) {
        expect(text.style?.fontWeight, FontWeight.bold);
        expect(text.style?.fontSize, 20);
      }

      // Assert - Check price text style
      final priceText = tester.widget<Text>(find.text('\$13.00/h'));
      expect(priceText.style?.fontSize, 16);
    });

    testWidgets('should handle large numbers correctly', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '11',
        model: 'Test Moto',
        fuelCapacity: 99.9,
        distance: 999.9,
        pricePerHour: 99.99,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.text(' 1000km'), findsOneWidget); // 999.9 làm tròn = 1000
      expect(find.text(' 100L'), findsOneWidget);    // 99.9 làm tròn = 100
      expect(find.text('\$99.99/h'), findsOneWidget);
    });

    testWidgets('should handle small numbers correctly', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '12',
        model: 'Test Moto Mini',
        fuelCapacity: 0.5,
        distance: 0.3,
        pricePerHour: 0.99,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert - Vì 0.5 làm tròn = 1, không phải 0
      expect(find.text(' 0km'), findsOneWidget);      // 0.3 làm tròn = 0
      expect(find.text(' 1L'), findsOneWidget);       // 0.5 làm tròn = 1
      expect(find.text('\$0.99/h'), findsOneWidget);
    });

    testWidgets('should display GPS and pump icons', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '13',
        model: 'Icon Test Moto',
        fuelCapacity: 10.0,
        distance: 20.0,
        pricePerHour: 15.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      final images = tester.widgetList<Image>(find.byType(Image));
      expect(images.length, 3); // moto_img.png, gps.png, pump.png
    });

    testWidgets('should have proper spacing and padding', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '14',
        model: 'Spacing Test',
        fuelCapacity: 8.0,
        distance: 15.0,
        pricePerHour: 10.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ).first,
      );

      expect(container.margin, const EdgeInsets.symmetric(vertical: 10, horizontal: 20));
      expect(container.padding, const EdgeInsets.all(20));

      // Check SizedBox spacing
      expect(find.byType(SizedBox), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 10);
    });

    testWidgets('should wrap in GestureDetector for tap handling', (WidgetTester tester) async {
      // Arrange
      final testMoto = MotoEntity(
        id: '15',
        model: 'Gesture Test',
        fuelCapacity: 6.0,
        distance: 12.0,
        pricePerHour: 9.0,
        status: 'available',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotoCard(moto: testMoto),
          ),
        ),
      );

      // Assert
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });

  group('MotoCard Integration Tests', () {
    testWidgets('should display multiple motos with different data', (WidgetTester tester) async {
      // Arrange
      final motos = [
        MotoEntity(id: '1', model: 'Honda Vision', fuelCapacity: 5.5, distance: 10.0, pricePerHour: 8.0, status: 'available'),
        MotoEntity(id: '2', model: 'Yamaha Aerox', fuelCapacity: 7.0, distance: 20.0, pricePerHour: 12.0, status: 'rented'),
        MotoEntity(id: '3', model: 'Vespa Sprint', fuelCapacity: 9.0, distance: 15.0, pricePerHour: 10.0, status: 'available'),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: motos.map((moto) => MotoCard(moto: moto)).toList(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Honda Vision'), findsNWidgets(2));
      expect(find.text('Yamaha Aerox'), findsNWidgets(2));
      expect(find.text('Vespa Sprint'), findsNWidgets(2));
      expect(find.text('Status: AVAILABLE'), findsNWidgets(2));
      expect(find.text('Status: RENTED'), findsOneWidget);
    });

    testWidgets('should have tap functionality on each card', (WidgetTester tester) async {
      // Arrange
      final motos = [
        MotoEntity(id: '1', model: 'Honda Vision', fuelCapacity: 5.5, distance: 10.0, pricePerHour: 8.0, status: 'available'),
        MotoEntity(id: '2', model: 'Yamaha Aerox', fuelCapacity: 7.0, distance: 20.0, pricePerHour: 12.0, status: 'available'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: motos.map((moto) => MotoCard(moto: moto)).toList(),
            ),
          ),
        ),
      );

      // Assert - Check all cards have GestureDetector
      expect(find.byType(GestureDetector), findsNWidgets(2));

      // Verify each GestureDetector has onTap callback
      final gestureDetectors = tester.widgetList<GestureDetector>(find.byType(GestureDetector));
      for (var detector in gestureDetectors) {
        expect(detector.onTap, isNotNull);
      }
    });
  });
}