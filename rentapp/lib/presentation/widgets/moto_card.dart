import 'package:flutter/material.dart';

import '../../data/models/moto.dart';

class MotoCard extends StatelessWidget {
  final Moto moto;

  const MotoCard({super.key, required this.moto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset('assets/moto_image.png', height: 120,),
          Text(moto.model, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/gps.png'),
                  Text('${moto.distance.toStringAsFixed(0)}km')
                ],
              ),
              Row(
                children: [
                  Image.asset('assets/pump.png'),
                  Text('${moto.fuelCapacity.toStringAsFixed(0)}km')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}