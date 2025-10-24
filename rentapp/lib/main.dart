import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/firebase_options.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_bloc.dart';
import 'package:rentapp/features/moto/presentation/pages/moto_crud_screen.dart';
import 'package:rentapp/features/owner/presentation/page/moto_crud_page.dart';
import 'package:rentapp/features/moto/moto_injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/features/moto/presentation/widget/map_picker_screen.dart';
import 'package:rentapp/features/auth/presentation/page/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await di.initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: BlocProvider(
      //   create: (context) => di.sl<MotoBloc>(),
      //   child: const MotoCrudScreen(),
      // ),
      home: const Login(),
    );
  }
}

