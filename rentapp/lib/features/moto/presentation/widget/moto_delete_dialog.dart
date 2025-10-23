import 'package:flutter/material.dart';
import 'package:rentapp/core/constants/app_colors.dart';

class MotoDeleteDialog extends StatelessWidget {
  const MotoDeleteDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const MotoDeleteDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surfaceWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Delete Vehicle',
        style: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this vehicle? This action cannot be undone.',
        style: TextStyle(color: AppColors.textGray),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textGray),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.errorRed,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}