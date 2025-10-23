import 'package:flutter/material.dart';
import 'package:rentapp/core/constants/app_colors.dart';
import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';
import 'moto_info_chip.dart';

class MotoCard extends StatelessWidget {
  final MotoEntity moto;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MotoCard({
    super.key,
    required this.moto,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildInfoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _buildIconContainer(),
        const SizedBox(width: 16),
        Expanded(child: _buildTitleSection()),
        _buildEditButton(),
        const SizedBox(width: 8),
        _buildDeleteButton(),
      ],
    );
  }

  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.motorcycle_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          moto.model,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
           '\$${moto.pricePerHour.toStringAsFixed(2)}/hour',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return IconButton(
      icon: const Icon(
        Icons.edit_rounded,
        color: AppColors.primaryGreen,
        size: 22,
      ),
      onPressed: onEdit,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: const Icon(
        Icons.delete_rounded,
        color: AppColors.errorRed,
        size: 22,
      ),
      onPressed: onDelete,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.errorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: MotoInfoChip(
              icon: Icons.local_gas_station_rounded,
              label: 'Fuel',
              value: '${moto.fuelCapacity} L',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.borderLight,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: MotoInfoChip(
              icon: Icons.speed_rounded,
              label: 'Distance',
              value: '${moto.distance} km',
            ),
          ),
        ],
      ),
    );
  }
}