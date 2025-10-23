import 'package:equatable/equatable.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

abstract class MotoEvent extends Equatable {
  const MotoEvent();

  @override
  List<Object?> get props => [];
}

class LoadMotosEvent extends MotoEvent {
  const LoadMotosEvent();
}

class AddMotoEvent extends MotoEvent {
  final MotoEntity moto;
  const AddMotoEvent(this.moto);

  @override
  List<Object?> get props => [moto];
}

class UpdateMotoEvent extends MotoEvent {
  final MotoEntity moto;
  const UpdateMotoEvent(this.moto);

  @override
  List<Object?> get props => [moto];
}

class DeleteMotoEvent extends MotoEvent {
  final String motoId;
  const DeleteMotoEvent(this.motoId);

  @override
  List<Object?> get props => [motoId];
}