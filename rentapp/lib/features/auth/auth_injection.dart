// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Data sources
import 'package:rentapp/features/auth/data/auth_remote_data_source.dart';

// Repositories
import 'package:rentapp/features/auth/data/auth_repository_impl.dart';
import 'package:rentapp/features/auth/domain/repositories/auth_repository.dart';

// Use cases
import 'package:rentapp/features/auth/domain/usecases/sign_in.dart';
import 'package:rentapp/features/auth/domain/usecases/sign_up.dart';
import 'package:rentapp/features/auth/domain/usecases/sign_in_with_google.dart';

// Bloc
import 'package:rentapp/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ============ Features - Auth ============
  
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signInWithGoogleUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );

  // ============ External ============
  
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  
  // Google Sign In
  sl.registerLazySingleton(
    () => GoogleSignIn(
      serverClientId:
          '105583620603-q46tu05ug90qjv5cp2hr1d76jqpkhi1s.apps.googleusercontent.com',
      scopes: ['email', 'profile'],
    ),
  );
}