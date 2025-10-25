import 'package:flutter/material.dart';
import 'package:rentapp/presentation/pages/moto_details_page.dart';
import '../../data/models/moto_model.dart';

class MotoCard extends StatelessWidget {
  final Moto moto;
  const MotoCard({super.key, required this.moto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotoDetailsPage(moto: moto)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5),
          ],
        ),
        child: Column(
          children: [
            Image.asset('assets/moto_img.png', height: 120),
            Text(
              moto.model,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            // Check
            Text(moto.model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Status: ${moto.status.toUpperCase()}', style: TextStyle(color: moto.status == 'available' ? Colors.green : Colors.red)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/gps.png'),
                        Text(' ${moto.distance.toStringAsFixed(0)}km'),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/pump.png'),
                        Text(' ${moto.fuelCapacity.toStringAsFixed(0)}L'),
                      ],
                    ),
                  ],
                ),
                Text(
                  // Dòng đã được sửa ở đây
                  '\$${moto.pricePerHour.toStringAsFixed(2)}/h',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
