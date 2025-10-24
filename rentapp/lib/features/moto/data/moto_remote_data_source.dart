import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentapp/data/models/moto.dart';

abstract class MotoRemoteDataSource {
  Future<void> addMoto(Moto moto);
  Future<void> updateMoto(Moto moto);
  Future<void> deleteMoto(String id);
  Future<List<Moto>> getAllMotos();
  Future<Moto?> getMotoById(String id);
}

class MotoRemoteDataSourceImpl implements MotoRemoteDataSource {
  final FirebaseFirestore firestore;

  MotoRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addMoto(Moto moto) async {
    await firestore.collection('Motos').add(moto.toMap());
  }

  @override
  Future<void> updateMoto(Moto moto) async {
    await firestore.collection('Motos').doc(moto.id).update(moto.toMap());
  }

  @override
  Future<void> deleteMoto(String id) async {
    await firestore.collection('Motos').doc(id).delete();
  }

  @override
  Future<List<Moto>> getAllMotos() async {
    final snapshot = await firestore.collection('Motos').get();
    return snapshot.docs.map((doc) => Moto.fromFirestore(doc)).toList();
  }

  @override
  Future<Moto?> getMotoById(String id) async {
    final doc = await firestore.collection('Motos').doc(id).get();
    if (!doc.exists) return null;
    return Moto.fromFirestore(doc);
  }
}
