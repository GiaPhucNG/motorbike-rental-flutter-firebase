import 'package:cloud_firestore/cloud_firestore.dart';

class Moto {
  final String? id; // ✅ Thêm trường id, có thể null khi tạo mới
  final String model;
  final double fuelCapacity;
  final double distance;
  final double pricePerHour;

  Moto({
    this.id, // ✅ Thêm id vào constructor
    required this.model,
    required this.fuelCapacity,
    required this.distance,
    required this.pricePerHour,
  });

  // ✅ Chuyển đổi từ Firestore DocumentSnapshot sang đối tượng Moto
  factory Moto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Moto(
      id: doc.id, // Lấy ID từ chính document
      model: data['model'] ?? '',
      distance: (data['distance'] as num?)?.toDouble() ?? 0.0,
      fuelCapacity: (data['fuelCapacity'] as num?)?.toDouble() ?? 0.0,
      pricePerHour: (data['pricePerHour'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // ✅ Chuyển đổi từ đối tượng Moto sang Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'fuelCapacity': fuelCapacity,
      'distance': distance,
      'pricePerHour': pricePerHour,
    };
  }
}