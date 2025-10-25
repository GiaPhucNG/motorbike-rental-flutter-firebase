import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import các file Dependency Injection (DI) của từng feature
// Đặt tên riêng cho chúng để tránh trùng lặp (ví dụ: auth_di, moto_di)
import 'package:rentapp/features/auth/auth_injection.dart' as auth_di;
import 'package:rentapp/features/moto/moto_injection.dart' as moto_di;

// Import các BLoC bạn muốn cung cấp cho toàn ứng dụng
import 'package:rentapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_bloc.dart';

// Import trang bắt đầu của bạn
import 'package:rentapp/features/auth/presentation/page/login_page.dart'; // hoặc signup_page.dart
import 'package:rentapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("--- APP STARTING ---");

  print("1. Initializing Firebase...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("✅ 2. Firebase Initialized SUCCESSFULLY.");

  print("3. Initializing Auth Dependencies...");
  await auth_di.init();
  print("✅ 4. Auth Dependencies Initialized.");

  print("5. Initializing Moto Dependencies...");
  await moto_di.initializeDependencies();
  print("✅ 6. Moto Dependencies Initialized.");

  print("🚀 LAUNCHING APP...");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng MultiBlocProvider để cung cấp nhiều BLoC cùng lúc
    return MultiBlocProvider(
      providers: [
        // Cung cấp AuthBloc
        BlocProvider<AuthBloc>(
          create: (_) => auth_di.sl<AuthBloc>(),
        ),
        // Cung cấp MotoBloc
        BlocProvider<MotoBloc>(
          create: (_) => moto_di.sl<MotoBloc>(),
        ),
        // Thêm các BLoC khác của bạn ở đây nếu có...
        // BlocProvider<AnotherBloc>(create: (_) => di.sl<AnotherBloc>()),
      ],
      child: MaterialApp(
        title: 'ViMoTo App',
        debugShowCheckedModeBanner: false, // Tắt banner debug
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        // Trang đầu tiên khi mở app
        home: const LoginPage(),
      ),
    );
  }
}