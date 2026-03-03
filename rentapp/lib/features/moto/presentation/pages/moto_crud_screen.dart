import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/core/constants/app_colors.dart';
import 'package:rentapp/core/widgets/custom_snackbar.dart';
import 'package:rentapp/core/widgets/loading_indicator.dart';
import 'package:rentapp/data/models/moto_model.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_bloc.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_event.dart';
import 'package:rentapp/features/moto/presentation/bloc/moto_state.dart';
import 'package:rentapp/features/moto/presentation/widget/empty_state_widget.dart';
import 'package:rentapp/features/moto/presentation/widget/error_state_widget.dart';
import 'package:rentapp/features/moto/presentation/widget/moto_card.dart';
import 'package:rentapp/features/moto/presentation/widget/moto_delete_dialog.dart';
import 'package:rentapp/features/moto/presentation/widget/moto_form_dialog.dart';
import 'package:rentapp/features/owner/presentation/page/moto_review_owner_page.dart';

class MotoCrudScreen extends StatefulWidget {
  const MotoCrudScreen({super.key});

  @override
  State<MotoCrudScreen> createState() => _MotoCrudScreenState();
}

class _MotoCrudScreenState extends State<MotoCrudScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MotoBloc>().add(const LoadMotosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: _buildAppBar(),
      body: BlocConsumer<MotoBloc, MotoState>(
        listener: _handleBlocListener,
        builder: _buildBlocBuilder,
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surfaceWhite,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: const Text(
        'Manage Vehicles',
        style: TextStyle(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.borderLight),
      ),
    );
  }

  void _handleBlocListener(BuildContext context, MotoState state) {
    if (state is MotoOperationSuccess) {
      CustomSnackbar.showSuccess(context, state.message);
    } else if (state is MotoError) {
      CustomSnackbar.showError(context, state.message);
    }
  }

  Widget _buildBlocBuilder(BuildContext context, MotoState state) {
    if (state is MotoLoading) {
      return const LoadingIndicator(message: 'Loading vehicles...');
    }

    if (state is MotoError) {
      return ErrorStateWidget(errorMessage: state.message);
    }

    if (state is MotoLoaded) {
      if (state.motos.isEmpty) {
        return const EmptyStateWidget();
      }
      return _buildMotoList(state.motos);
    }

    if (state is MotoOperationSuccess) {
      if (state.motos.isEmpty) {
        return const EmptyStateWidget();
      }
      return _buildMotoList(state.motos);
    }

    return const SizedBox.shrink();
  }

  Widget _buildMotoList(List motos) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: motos.length,
      itemBuilder: (context, index) {
        final moto = motos[index];
        return MotoCard(
          moto: moto,
          onTap: () => _navigateToOwnerReviewPage(moto),
          onEdit: () => _showMotoFormDialog(moto: moto),
          onDelete: () => _handleDeleteMoto(moto.id!),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () => _showMotoFormDialog(),
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: const Icon(Icons.add_rounded),
      label: const Text(
        'Add Vehicle',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> _showMotoFormDialog({dynamic moto}) async {
    final result = await MotoFormDialog.show(context, moto: moto);

    if (result != null && mounted) {
      if (moto != null) {
        context.read<MotoBloc>().add(UpdateMotoEvent(result));
      } else {
        context.read<MotoBloc>().add(AddMotoEvent(result));
      }
    }
  }

  Future<void> _handleDeleteMoto(String motoId) async {
    final confirmed = await MotoDeleteDialog.show(context);

    if (confirmed == true && mounted) {
      context.read<MotoBloc>().add(DeleteMotoEvent(motoId));
    }
  }

  void _navigateToOwnerReviewPage(MotoEntity entity) {
    final moto = Moto(
      id: entity.id,
      model: entity.model,
      fuelCapacity: entity.fuelCapacity,
      distance: entity.distance,
      pricePerHour: entity.pricePerHour,
      status: entity.status,
      location: entity.location,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MotoReviewOwnerPage(moto: moto)),
    );
  }
}
