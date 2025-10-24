import 'package:equatable/equatable.dart';
import 'location_entity.dart';

class MotoEntity extends Equatable {
  final String? id;
  final String model;
  final double fuelCapacity;
  final double distance;
  final double pricePerHour;
  final String status;
  final LocationEntity? location;

  const MotoEntity({
    this.id,
    required this.model,
    required this.fuelCapacity,
    required this.distance,
    required this.pricePerHour,
    required this.status,
    this.location,
  });

  @override
  List<Object?> get props => [id, model, fuelCapacity, distance, pricePerHour, status, location];
}