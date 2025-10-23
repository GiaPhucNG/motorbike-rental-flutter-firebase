import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'package:rentapp/features/moto/domain/repositories/moto_repository.dart';
import 'package:rentapp/data/models/moto.dart';
import 'moto_remote_data_source.dart';

class MotoRepositoryImpl implements MotoRepository {
  final MotoRemoteDataSource remoteDataSource;

  MotoRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addMoto(MotoEntity moto) async {
    await remoteDataSource.addMoto(Moto(
      model: moto.model,
      fuelCapacity: moto.fuelCapacity,
      distance: moto.distance,
      pricePerHour: moto.pricePerHour,
    ));
  }

  @override
  Future<void> updateMoto(MotoEntity moto) async {
    await remoteDataSource.updateMoto(Moto(
      id: moto.id,
      model: moto.model,
      fuelCapacity: moto.fuelCapacity,
      distance: moto.distance,
      pricePerHour: moto.pricePerHour,
    ));
  }

  @override
  Future<void> deleteMoto(String id) async {
    await remoteDataSource.deleteMoto(id);
  }

  @override
  Future<List<MotoEntity>> getAllMotos() async {
    final motos = await remoteDataSource.getAllMotos();
    return motos
        .map((m) => MotoEntity(
              id: m.id,
              model: m.model,
              fuelCapacity: m.fuelCapacity,
              distance: m.distance,
              pricePerHour: m.pricePerHour,
            ))
        .toList();
  }

  @override
  Future<MotoEntity?> getMotoById(String id) async {
    final moto = await remoteDataSource.getMotoById(id);
    if (moto == null) return null;

    return MotoEntity(
      id: moto.id,
      model: moto.model,
      fuelCapacity: moto.fuelCapacity,
      distance: moto.distance,
      pricePerHour: moto.pricePerHour,
    );
  }
}
