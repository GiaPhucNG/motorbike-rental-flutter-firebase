import 'package:flutter/material.dart';
import 'package:motorbike_rental_app/data/models/moto.dart';
import 'package:motorbike_rental_app/presentation/widgets/more_card.dart';
import 'package:motorbike_rental_app/presentation/widgets/moto_card.dart';

class MotoDetailsPage extends StatelessWidget {
  final Moto moto;

  const MotoDetailsPage({super.key, required this.moto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            Text('Information')
          ],
        ),
      ),
      body: Column(
        children: [
          MotoCard(moto: Moto(model: moto.model, fuelCapacity: moto.fuelCapacity, distance: moto.distance, pricePerHour: moto.pricePerHour)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 40, backgroundImage: AssetImage('asset/user.png'),),
                        SizedBox(height: 10,),
                        Text('Phuc Nguyen', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('\$4,235', style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/maps.png'),
                          fit: BoxFit.cover
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20,),
            child: Column(
              children: [
                MoreCard(moto: Moto(model: moto.model+"-1", distance: moto.distance+100, fuelCapacity: moto.fuelCapacity+100, pricePerHour: moto.pricePerHour+10)),
                SizedBox(height: 10,),
                MoreCard(moto: Moto(model: moto.model+"-2", distance: moto.distance+200, fuelCapacity: moto.fuelCapacity+200, pricePerHour: moto.pricePerHour+20)),
                SizedBox(height: 10,),
                MoreCard(moto: Moto(model: moto.model+"-3", distance: moto.distance+300, fuelCapacity: moto.fuelCapacity+300, pricePerHour: moto.pricePerHour+30)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
