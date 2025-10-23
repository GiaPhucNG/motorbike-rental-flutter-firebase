import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'package:rentapp/features/moto/domain/repositories/moto_repository.dart';

class MotoCrudUseCase {
  final MotoRepository repository;

  MotoCrudUseCase(this.repository);

  Future<void> addMoto(MotoEntity moto) => repository.addMoto(moto);

  Future<void> updateMoto(MotoEntity moto) => repository.updateMoto(moto);

  Future<void> deleteMoto(String id) => repository.deleteMoto(id);

  Future<List<MotoEntity>> getAllMotos() => repository.getAllMotos();

  Future<MotoEntity?> getMotoById(String id) => repository.getMotoById(id);
}
