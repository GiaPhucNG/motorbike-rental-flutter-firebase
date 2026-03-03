import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/presentation/widgets/search_bar.dart' as CustomSearchBar;

void main() {
  group('SearchBar Widget Tests', () {
    late TextEditingController controller;
    late bool onChangedCalled;
    late bool onClearCalled;
    late String lastChangedValue;

    setUp(() {
      controller = TextEditingController();
      onChangedCalled = false;
      onClearCalled = false;
      lastChangedValue = '';
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('SearchBar renders correctly with empty text', (WidgetTester tester) async {
      // Arrange: Build the SearchBar with empty controller
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSearchBar.SearchBar(
              controller: controller,
              onChanged: (value) {
                onChangedCalled = true;
                lastChangedValue = value;
              },
              onClear: () {
                onClearCalled = true;
              },
            ),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check TextField, hint text, and search icon
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search your thoughts...'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsNothing); // No clear icon when empty
    });

    testWidgets('SearchBar renders clear icon when text is present', (WidgetTester tester) async {
      // Arrange: Set text in controller
      controller.text = 'test';

      // Build the SearchBar
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSearchBar.SearchBar(
              controller: controller,
              onChanged: (value) {
                onChangedCalled = true;
                lastChangedValue = value;
              },
              onClear: () {
                onClearCalled = true;
              },
            ),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check TextField, text, search icon, and clear icon
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('test'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('SearchBar has correct styling', (WidgetTester tester) async {
      // Arrange: Build the SearchBar
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSearchBar.SearchBar(
              controller: controller,
              onChanged: (value) {
                onChangedCalled = true;
                lastChangedValue = value;
              },
              onClear: () {
                onClearCalled = true;
              },
            ),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check Padding
      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);
      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, const EdgeInsets.all(16.0));

      // Assert: Check TextField decoration
      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;
      expect(decoration.hintText, 'Search your thoughts...');
      expect(decoration.fillColor, Colors.grey[200]);
      expect(decoration.filled, true);
      expect(
        decoration.border,
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    });

    testWidgets('SearchBar layout is correct', (WidgetTester tester) async {
      // Arrange: Build the SearchBar
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSearchBar.SearchBar(
              controller: controller,
              onChanged: (value) {
                onChangedCalled = true;
                lastChangedValue = value;
              },
              onClear: () {
                onClearCalled = true;
              },
            ),
          ),
        ),
      );

      // Act: Allow the widget tree to build
      await tester.pumpAndSettle();

      // Assert: Check Padding wrapping TextField
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.ancestor(of: find.byType(TextField), matching: find.byType(Padding)), findsOneWidget);
    });

    testWidgets('SearchBar calls onChanged when text is entered', (WidgetTester tester) async {
      // Arrange: Build the SearchBar in a StatefulWidget to handle rebuilds
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: CustomSearchBar.SearchBar(
                controller: controller,
                onChanged: (value) {
                  onChangedCalled = true;
                  lastChangedValue = value;
                  setState(() {}); // Trigger rebuild on text change
                },
                onClear: () {
                  onClearCalled = true;
                },
              ),
            ),
          ),
        ),
      );

      // Act: Enter text
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump(); // Trigger rebuild after text input

      // Assert: Verify onChanged was called with correct value
      expect(onChangedCalled, isTrue);
      expect(lastChangedValue, 'test');
      expect(find.byIcon(Icons.clear), findsOneWidget); // Clear icon appears
    });

    testWidgets('SearchBar calls onClear when clear button is tapped', (WidgetTester tester) async {
      // Arrange: Set initial text
      controller.text = 'test';

      // Build the SearchBar in a StatefulWidget to handle rebuilds
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: CustomSearchBar.SearchBar(
                controller: controller,
                onChanged: (value) {
                  onChangedCalled = true;
                  lastChangedValue = value;
                  setState(() {}); // Trigger rebuild on text change
                },
                onClear: () {
                  onClearCalled = true;
                  controller.clear();
                  setState(() {}); // Trigger rebuild after clear
                },
              ),
            ),
          ),
        ),
      );

      // Act: Tap the clear button
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump(); // Trigger rebuild after clear

      // Assert: Verify onClear was called and clear icon disappears
      expect(onClearCalled, isTrue);
      expect(controller.text, isEmpty);
      expect(find.byIcon(Icons.clear), findsNothing);
    });
  });
}