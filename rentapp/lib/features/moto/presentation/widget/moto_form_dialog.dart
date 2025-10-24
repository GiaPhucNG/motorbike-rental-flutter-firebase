import 'package:flutter/material.dart';
import 'package:rentapp/core/constants/app_colors.dart';
import 'package:rentapp/data/models/moto.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'package:rentapp/features/moto/presentation/widget/map_picker_screen.dart';
import 'package:rentapp/features/moto/domain/entities/location_entity.dart';
import 'package:latlong2/latlong.dart';
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
  LocationEntity? _selectedLocationEntity;

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
    
    // Lấy location từ moto nếu có
    _selectedLocationEntity = widget.moto?.location;
    
    // Debug: In ra để kiểm tra
    print('=== MotoFormDialog initState ===');
    print('isEditing: $isEditing');
    print('widget.moto: ${widget.moto}');
    print('location from moto: ${widget.moto?.location}');
    print('_selectedLocationEntity: $_selectedLocationEntity');
  }

  @override
  void dispose() {
    _modelController.dispose();
    _fuelController.dispose();
    _distanceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Hàm mở map picker
  Future<void> _pickLocationOnMap() async {
    // Chuyển LocationEntity thành LatLng nếu đã có location
    LatLng? initialLocation;
    if (_selectedLocationEntity != null) {
      initialLocation = LatLng(
        _selectedLocationEntity!.latitude,
        _selectedLocationEntity!.longitude,
      );
    }

    // Mở MapPickerScreen và nhận kết quả
    final LatLng? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapPickerScreen(
          initialLocation: initialLocation,
        ),
      ),
    );

    // Nếu người dùng chọn vị trí, lưu vào state
    if (result != null) {
      setState(() {
        _selectedLocationEntity = LocationEntity(
          latitude: result.latitude,
          longitude: result.longitude,
        );
      });
    }
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
            const SizedBox(height: 20),
            // Nút chọn vị trí trên bản đồ
            _buildLocationPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    final hasLocation = _selectedLocationEntity != null;

    return InkWell(
      onTap: _pickLocationOnMap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: hasLocation ? AppColors.primaryGreen : AppColors.borderLight,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          color: hasLocation 
              ? AppColors.primaryGreen.withOpacity(0.05) 
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: hasLocation 
                    ? AppColors.primaryGreen.withOpacity(0.1)
                    : AppColors.borderLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.location_on_rounded,
                color: hasLocation ? AppColors.primaryGreen : AppColors.textGray,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasLocation ? 'Location Selected' : 'Pick Location',
                    style: TextStyle(
                      color: hasLocation ? AppColors.primaryGreen : AppColors.textGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (hasLocation) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${_selectedLocationEntity!.latitude.toStringAsFixed(6)}, '
                      '${_selectedLocationEntity!.longitude.toStringAsFixed(6)}',
                      style: const TextStyle(
                        color: AppColors.textGray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: hasLocation ? AppColors.primaryGreen : AppColors.textGray,
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
    
    // DEBUG
    print('═══════════════════════════════════════');
    print('💾 HANDLE SAVE');
    print('Model: $model');
    print('Location: $_selectedLocationEntity');
    print('═══════════════════════════════════════\n');
    
    if (model.isNotEmpty) {
      final moto = Moto(
        id: isEditing ? widget.moto!.id : null,
        model: model,
        fuelCapacity: double.tryParse(_fuelController.text) ?? 0.0,
        distance: double.tryParse(_distanceController.text) ?? 0.0,
        pricePerHour: double.tryParse(_priceController.text) ?? 0.0,
        location: _selectedLocationEntity, // Lưu location đã chọn
      );
      
      print('Moto object created: $moto');
      Navigator.of(context).pop(moto);
    }
  }
}