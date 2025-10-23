// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rentapp/data/models/moto.dart';
// import 'package:rentapp/features/moto/data/moto_remote_data_source.dart';
// import 'package:rentapp/features/moto/data/moto_repository_impl.dart';
// import 'package:rentapp/features/moto/domain/usecases/moto_crud_usecase.dart';
// import 'package:rentapp/features/moto/domain/entities/moto_entity.dart';

// const Color primaryGreen = Color(0xFF10B981);
// const Color darkGreen = Color(0xFF059669);
// const Color lightGreen = Color(0xFFD1FAE5);
// const Color surfaceWhite = Color(0xFFFFFFFF);
// const Color backgroundGray = Color(0xFFF9FAFB);
// const Color textDark = Color(0xFF111827);
// const Color textGray = Color(0xFF6B7280);
// const Color borderLight = Color(0xFFE5E7EB);

// class MotoCrudScreen extends StatefulWidget {
//   const MotoCrudScreen({super.key});

//   @override
//   State<MotoCrudScreen> createState() => _MotoCrudScreenState();
// }

// class _MotoCrudScreenState extends State<MotoCrudScreen> {
//   // MARK: - Dependencies Initialization
//   late final MotoRemoteDataSourceImpl _remoteDataSource = MotoRemoteDataSourceImpl(FirebaseFirestore.instance);
//   late final MotoRepositoryImpl _motoRepository = MotoRepositoryImpl(_remoteDataSource);
//   late final MotoCrudUseCase _motoUseCase = MotoCrudUseCase(_motoRepository);

//   // Biến state để quản lý việc tải dữ liệu cho FutureBuilder
//   late Future<List<MotoEntity>> _motosFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loadMotos();
//   }

//   void _loadMotos() {
//     setState(() {
//       _motosFuture = _motoUseCase.getAllMotos();
//     });
//   }

//   // MARK: - Dialogs and Actions
//   Future<void> _showMotoDialog({MotoEntity? moto}) async {
//     final isEditing = moto != null;
//     final modelController = TextEditingController(text: moto?.model ?? '');
//     final fuelController = TextEditingController(text: moto?.fuelCapacity.toString() ?? '');
//     final distanceController = TextEditingController(text: moto?.distance.toString() ?? '');
//     final priceController = TextEditingController(text: moto?.pricePerHour.toString() ?? '');

//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 500),
//             decoration: BoxDecoration(
//               color: surfaceWhite,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 40,
//                   offset: const Offset(0, 20),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header with gradient
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [primaryGreen, darkGreen],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           isEditing ? Icons.edit_rounded : Icons.add_rounded,
//                           color: Colors.white,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Text(
//                           isEditing ? 'Edit Vehicle' : 'Add New Vehicle',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: -0.5,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Form content
//                 Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         _buildModernTextField(
//                           controller: modelController,
//                           label: 'Model Name',
//                           icon: Icons.motorcycle_rounded,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildModernTextField(
//                           controller: priceController,
//                           label: 'Price per Hour',
//                           icon: Icons.attach_money_rounded,
//                           isNumber: true,
//                           prefix: '\$',
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildModernTextField(
//                                 controller: fuelController,
//                                 label: 'Fuel (L)',
//                                 icon: Icons.local_gas_station_rounded,
//                                 isNumber: true,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: _buildModernTextField(
//                                 controller: distanceController,
//                                 label: 'Distance (km)',
//                                 icon: Icons.speed_rounded,
//                                 isNumber: true,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Actions
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () => Navigator.of(context).pop(),
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             side: const BorderSide(
//                               color: borderLight,
//                               width: 1.5,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(
//                               color: textGray,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             final model = modelController.text;
//                             if (model.isNotEmpty) {
//                               try {
//                                 final motoToSave = Moto(
//                                   id: isEditing ? moto.id : null,
//                                   model: model,
//                                   fuelCapacity:
//                                       double.tryParse(fuelController.text) ?? 0.0,
//                                   distance:
//                                       double.tryParse(distanceController.text) ?? 0.0,
//                                   pricePerHour:
//                                       double.tryParse(priceController.text) ?? 0.0,
//                                 );

//                                 if (isEditing) {
//                                   await _motoUseCase.updateMoto(motoToSave);
//                                 } else {
//                                   await _motoUseCase.addMoto(motoToSave);
//                                 }

//                                 _loadMotos();

//                                 if (!mounted) return;
//                                 Navigator.of(context).pop();
//                                 _showSuccessSnackbar(
//                                   isEditing
//                                       ? 'Vehicle updated successfully!'
//                                       : 'Vehicle added successfully!',
//                                 );
//                               } catch (e) {
//                                 _showErrorSnackbar('Failed to save: $e');
//                               }
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryGreen,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Save',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _deleteMoto(String id) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: surfaceWhite,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text(
//           'Delete Vehicle',
//           style: TextStyle(color: textDark, fontWeight: FontWeight.w700),
//         ),
//         content: const Text(
//           'Are you sure you want to delete this vehicle? This action cannot be undone.',
//           style: TextStyle(color: textGray),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel', style: TextStyle(color: textGray)),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red.shade500,
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed == true) {
//       try {
//         await _motoUseCase.deleteMoto(id);
//         _loadMotos();
//         _showSuccessSnackbar('Vehicle deleted successfully!');
//       } catch (e) {
//         _showErrorSnackbar('Failed to delete: $e');
//       }
//     }
//   }

//   void _showSuccessSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.check_circle_rounded,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: primaryGreen,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.error_rounded,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: Colors.red.shade500,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   // MARK: - UI Build Method
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundGray,
//       appBar: AppBar(
//         backgroundColor: surfaceWhite,
//         elevation: 0,
//         scrolledUnderElevation: 1,
//         surfaceTintColor: Colors.transparent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_rounded),
//           color: textDark,
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Manage Vehicles',
//           style: TextStyle(
//             color: textDark,
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             letterSpacing: -0.5,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(height: 1, color: borderLight),
//         ),
//       ),
//       body: FutureBuilder<List<MotoEntity>>(
//         future: _motosFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     color: primaryGreen,
//                     strokeWidth: 3,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Loading vehicles...',
//                     style: TextStyle(color: textGray),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline_rounded,
//                     size: 64,
//                     color: Colors.red.shade300,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Something went wrong',
//                     style: TextStyle(
//                       color: textDark,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Please try again later: ${snapshot.error}',
//                     style: const TextStyle(color: textGray),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(32),
//                     decoration: const BoxDecoration(
//                       color: lightGreen,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.motorcycle_rounded,
//                       size: 80,
//                       color: primaryGreen,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     'No vehicles yet',
//                     style: TextStyle(
//                       color: textDark,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Tap the + button to add your first vehicle',
//                     style: TextStyle(color: textGray, fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final motos = snapshot.data!;
//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: motos.length,
//             itemBuilder: (context, index) {
//               final moto = motos[index];
//               return _buildMotoCard(moto);
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showMotoDialog(),
//         backgroundColor: primaryGreen,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         icon: const Icon(Icons.add_rounded),
//         label: const Text(
//           'Add Vehicle',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }

//   // MARK: - Helper Widgets
//   Widget _buildMotoCard(MotoEntity moto) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: surfaceWhite,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: borderLight, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: () => _showMotoDialog(moto: moto),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [primaryGreen, darkGreen],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: const Icon(
//                         Icons.motorcycle_rounded,
//                         color: Colors.white,
//                         size: 26,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             moto.model,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                               color: textDark,
//                               letterSpacing: -0.3,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: lightGreen,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               '\$${moto.pricePerHour.toStringAsFixed(2)}/hour',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: darkGreen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit_rounded,
//                         color: primaryGreen,
//                         size: 22,
//                       ),
//                       onPressed: () => _showMotoDialog(moto: moto),
//                       style: IconButton.styleFrom(
//                         backgroundColor: lightGreen,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton(
//                       icon: Icon(
//                         Icons.delete_rounded,
//                         color: Colors.red.shade400,
//                         size: 22,
//                       ),
//                       onPressed: () => _deleteMoto(moto.id!),
//                       style: IconButton.styleFrom(
//                         backgroundColor: Colors.red.shade50,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: backgroundGray,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _buildInfoChip(
//                           icon: Icons.local_gas_station_rounded,
//                           label: 'Fuel',
//                           value: '${moto.fuelCapacity} L',
//                         ),
//                       ),
//                       Container(
//                         width: 1,
//                         height: 40,
//                         color: borderLight,
//                         margin: const EdgeInsets.symmetric(horizontal: 12),
//                       ),
//                       Expanded(
//                         child: _buildInfoChip(
//                           icon: Icons.speed_rounded,
//                           label: 'Distance',
//                           value: '${moto.distance} km',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, color: primaryGreen, size: 20),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           style: const TextStyle(
//             color: textGray,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: const TextStyle(
//             color: textDark,
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             letterSpacing: -0.3,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildModernTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isNumber = false,
//     String? prefix,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: isNumber
//           ? const TextInputType.numberWithOptions(decimal: true)
//           : TextInputType.text,
//       style: const TextStyle(
//         color: textDark,
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(
//           color: textGray,
//           fontWeight: FontWeight.w500,
//         ),
//         prefixIcon: Icon(icon, color: primaryGreen, size: 22),
//         prefixText: prefix,
//         prefixStyle: const TextStyle(
//           color: textDark,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//         filled: true,
//         fillColor: backgroundGray,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: borderLight, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: const BorderSide(color: primaryGreen, width: 2),
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 16,
//         ),
//       ),
//     );
//   }
// }