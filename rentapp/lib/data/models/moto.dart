import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart'; 
import 'package:rentapp/features/moto/domain/entities/location_entity.dart';

// Thêm `extends MotoEntity` ở đây
class Moto extends MotoEntity {
  
  // Constructor sẽ gọi constructor của lớp cha (super)
  const Moto({
    String? id,
    required String model,
    required double fuelCapacity,
    required double distance,
    required double pricePerHour,
    LocationEntity? location,
  }) : super(
          id: id,
          model: model,
          fuelCapacity: fuelCapacity,
          distance: distance,
          pricePerHour: pricePerHour,
          location: location,
        );

  // Các phương thức dành riêng cho lớp Data vẫn giữ nguyên
  factory Moto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final geoPoint = data['location'] as GeoPoint?;
    final location = geoPoint != null 
        ? LocationEntity(latitude: geoPoint.latitude, longitude: geoPoint.longitude) 
        : null;
    return Moto(
      id: doc.id,
      model: data['model'] as String,
      fuelCapacity: (data['fuelCapacity'] as num).toDouble(),
      distance: (data['distance'] as num).toDouble(),
      pricePerHour: (data['pricePerHour'] as num).toDouble(),
      location: location
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'fuelCapacity': fuelCapacity,
      'distance': distance,
      'pricePerHour': pricePerHour,
      'location': location != null 
          ? GeoPoint(location!.latitude, location!.longitude) 
          : null,
      'status': status,
    };
  }
}