import 'package:flutter/material.dart';
import 'package:rentapp/core/constants/app_colors.dart';
import 'package:rentapp/data/models/moto.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'modern_text_field.dart';

class MotoFormDialog extends StatefulWidget {
  final MotoEntity? moto;

  const MotoFormDialog({super.key, this.moto});

  static Future<Moto?> show(
    BuildContext context, {
    MotoEntity? moto,
  }) {
    return showDialog<Moto>(
      context: context,
      barrierDismissible: false,
      builder: (context) => MotoFormDialog(moto: moto),
    );
  }

  @override
  State<MotoFormDialog> createState() => _MotoFormDialogState();
}

class _MotoFormDialogState extends State<MotoFormDialog> {
  late final TextEditingController _modelController;
  late final TextEditingController _fuelController;
  late final TextEditingController _distanceController;
  late final TextEditingController _priceController;

  bool get isEditing => widget.moto != null;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(
      text: widget.moto?.model ?? '',
    );
    _fuelController = TextEditingController(
      text: widget.moto?.fuelCapacity.toString() ?? '',
    );
    _distanceController = TextEditingController(
      text: widget.moto?.distance.toString() ?? '',
    );
    _priceController = TextEditingController(
      text: widget.moto?.pricePerHour.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _modelController.dispose();
    _fuelController.dispose();
    _distanceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildFormContent(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isEditing ? Icons.edit_rounded : Icons.add_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isEditing ? 'Edit Vehicle' : 'Add New Vehicle',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ModernTextField(
              controller: _modelController,
              label: 'Model Name',
              icon: Icons.motorcycle_rounded,
            ),
            const SizedBox(height: 20),
            ModernTextField(
              controller: _priceController,
              label: 'Price per Hour',
              icon: Icons.attach_money_rounded,
              isNumber: true,
              prefix: '\$',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ModernTextField(
                    controller: _fuelController,
                    label: 'Fuel (L)',
                    icon: Icons.local_gas_station_rounded,
                    isNumber: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ModernTextField(
                    controller: _distanceController,
                    label: 'Distance (km)',
                    icon: Icons.speed_rounded,
                    isNumber: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(
                  color: AppColors.borderLight,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    final model = _modelController.text;
    if (model.isNotEmpty) {
      final moto = Moto(
        id: isEditing ? widget.moto!.id : null,
        model: model,
        fuelCapacity: double.tryParse(_fuelController.text) ?? 0.0,
        distance: double.tryParse(_distanceController.text) ?? 0.0,
        pricePerHour: double.tryParse(_priceController.text) ?? 0.0,
      );
      Navigator.of(context).pop(moto);
    }
  }
}