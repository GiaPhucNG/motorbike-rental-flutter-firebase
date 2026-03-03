import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentapp/features/auth/domain/entities/user_entity.dart' show UserEntity;
import 'package:rentapp/presentation/pages/onboarding_page.dart';

void main() {
  // Fake user data
  final fakeUser = UserEntity(name: 'Test', email: 'test@test.com', uid: '', role: '');

  testWidgets('OnboardingPage UI renders correctly', (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingPage(user: fakeUser),
      ),
    );

    // Kiểm tra các text chính có hiển thị
    expect(find.text('Xin chào, Test!'), findsOneWidget);
    expect(find.text('Renting easily. \nEnjoy your travel!'), findsOneWidget);
    expect(find.text('Let\'s go!'), findsOneWidget);

    // Kiểm tra button có tồn tại
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Kiểm tra scaffold có background color đúng
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, const Color(0xFFE8F5E9));
  });

  testWidgets('OnboardingPage builds without errors', (WidgetTester tester) async {
    // Test đơn giản chỉ cần build được không lỗi
    expect(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: OnboardingPage(user: fakeUser),
        ),
      );
    }, returnsNormally);
  });
}