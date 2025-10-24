import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

abstract class MotoRepository {
  Future<void> addMoto(MotoEntity moto);
  Future<void> updateMoto(MotoEntity moto);
  Future<void> deleteMoto(String id);
  Future<List<MotoEntity>> getAllMotos();
  Future<MotoEntity?> getMotoById(String id);
}