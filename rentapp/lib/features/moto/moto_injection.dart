// injection_container.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:rentapp/features/moto/data/moto_remote_data_source.dart';
import 'package:rentapp/features/moto/data/moto_repository_impl.dart';
import 'package:rentapp/features/moto/domain/repositories/moto_repository.dart';
import 'package:rentapp/features/moto/domain/usecases/moto_crud_usecase.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data Sources
  sl.registerLazySingleton<MotoRemoteDataSource>(
    () => MotoRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<MotoRepository>(
    () => MotoRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => MotoCrudUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => MotoBloc(motoCrudUseCase: sl()),
  );
}