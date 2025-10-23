import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/features/moto/domain/usecases/moto_crud_usecase.dart';
import 'moto_event.dart';
import 'moto_state.dart';

class MotoBloc extends Bloc<MotoEvent, MotoState> {
  final MotoCrudUseCase motoCrudUseCase;
  MotoBloc({
    required this.motoCrudUseCase,
  }) : super(const MotoInitial()) {
    on<LoadMotosEvent>(_onLoadMotos);
    on<AddMotoEvent>(_onAddMoto);
    on<UpdateMotoEvent>(_onUpdateMoto);
    on<DeleteMotoEvent>(_onDeleteMoto);
  }

  Future<void> _onLoadMotos(
    LoadMotosEvent event,
    Emitter<MotoState> emit,
  ) async {
    emit(const MotoLoading());
    try {
      final motos = await motoCrudUseCase.getAllMotos();
      print(motos);
      emit(MotoLoaded(motos));
    } catch (e) {
      emit(MotoError('Failed to load vehicles: ${e.toString()}'));
    }
  }

  Future<void> _onAddMoto(
    AddMotoEvent event,
    Emitter<MotoState> emit,
  ) async {
    try {
      await motoCrudUseCase.addMoto(event.moto);
      final motos = await motoCrudUseCase.getAllMotos();
      emit(MotoOperationSuccess(
        message: 'Vehicle added successfully!',
        motos: motos,
      ));
    } catch (e) {
      emit(MotoError('Failed to add vehicle: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateMoto(
    UpdateMotoEvent event,
    Emitter<MotoState> emit,
  ) async {
    try {
      await motoCrudUseCase.updateMoto(event.moto);
      final motos = await motoCrudUseCase.getAllMotos();
      emit(MotoOperationSuccess(
        message: 'Vehicle updated successfully!',
        motos: motos,
      ));
    } catch (e) {
      emit(MotoError('Failed to update vehicle: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteMoto(
    DeleteMotoEvent event,
    Emitter<MotoState> emit,
  ) async {
    try {
      await motoCrudUseCase.deleteMoto(event.motoId);
      final motos = await motoCrudUseCase.getAllMotos();
      emit(MotoOperationSuccess(
        message: 'Vehicle deleted successfully!',
        motos: motos,
      ));
    } catch (e) {
      emit(MotoError('Failed to delete vehicle: ${e.toString()}'));
    }
  }
}