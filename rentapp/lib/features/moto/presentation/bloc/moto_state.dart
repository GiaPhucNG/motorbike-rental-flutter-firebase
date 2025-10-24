import 'package:equatable/equatable.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

abstract class MotoState extends Equatable {
  const MotoState();

  @override
  List<Object?> get props => [];
}

class MotoInitial extends MotoState {
  const MotoInitial();
}

class MotoLoading extends MotoState {
  const MotoLoading();
}

class MotoLoaded extends MotoState {
  final List<MotoEntity> motos;
  const MotoLoaded(this.motos);

  @override
  List<Object?> get props => [motos];
}

class MotoError extends MotoState {
  final String message;
  const MotoError(this.message);

  @override
  List<Object?> get props => [message];
}

class MotoOperationSuccess extends MotoState {
  final String message;
  final List<MotoEntity> motos;

  const MotoOperationSuccess({
    required this.message,
    required this.motos,
  });

  @override
  List<Object?> get props => [message, motos];
}