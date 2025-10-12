import 'package:flutter/material.dart';
import 'package:motorbike_rental_app/data/models/moto.dart';
import 'package:motorbike_rental_app/presentation/widgets/moto_card.dart';

class MotoListScreen extends StatelessWidget {
  final List<Moto> motos = [
    Moto(
      id: '001',
      model: 'Honda Vision',
      fuelCapacity: 5.5,    // Dung tích bình nhiên liệu (lít)
      distance: 10.0,       // Quãng đường đã đi (km)
      pricePerHour: 8.0,    // Giá thuê mỗi giờ (USD)
    ),
    // 2. Honda PCX 160 (Thương hiệu Honda)
    Moto(
      id: '002',
      model: 'Honda PCX 160',
      fuelCapacity: 8.0,
      distance: 15.0,
      pricePerHour: 10.0,
    ),
    // 3. Yamaha Aerox 155 (Thương hiệu Yamaha)
    Moto(
      id: '003',
      model: 'Yamaha Aerox 155',
      fuelCapacity: 5.5,
      distance: 20.0,
      pricePerHour: 12.0,
    ),
    // 4. Yamaha MT-03 (Thương hiệu Yamaha)
    Moto(
      id: '004',
      model: 'Yamaha MT-03',
      fuelCapacity: 14.0,
      distance: 25.0,
      pricePerHour: 15.0,
    ),
    // 5. Vespa Sprint (Thương hiệu Vespa)
    Moto(
      id: '005',
      model: 'Vespa Sprint',
      fuelCapacity: 7.0,
      distance: 12.0,
      pricePerHour: 10.0,
    ),
    // 6. Vespa GTS 300 (Thương hiệu Vespa)
    Moto(
      id: '006',
      model: 'Vespa GTS 300',
      fuelCapacity: 9.0,
      distance: 18.0,
      pricePerHour: 13.0,
    ),
    // 7. Suzuki Gixxer (Thương hiệu Suzuki)
    Moto(
      id: '007',
      model: 'Suzuki Gixxer',
      fuelCapacity: 12.0,
      distance: 30.0,
      pricePerHour: 14.0,
    ),
    // 8. Suzuki Hayabusa (Thương hiệu Suzuki)
    Moto(
      id: '008',
      model: 'Suzuki Hayabusa',
      fuelCapacity: 21.0,
      distance: 40.0,
      pricePerHour: 20.0,
    ),
    // 9. Kawasaki Ninja 250 (Thương hiệu Kawasaki)
    Moto(
      id: '009',
      model: 'Kawasaki Ninja 250',
      fuelCapacity: 17.0,
      distance: 25.0,
      pricePerHour: 18.0,
    ),
    // 10. Kawasaki Z900 (Thương hiệu Kawasaki)
    Moto(
      id: '010',
      model: 'Kawasaki Z900',
      fuelCapacity: 17.0,
      distance: 35.0,
      pricePerHour: 22.0,
    ),
    // 11. Hero Splendor Plus (Thương hiệu Hero)
    Moto(
      id: '011',
      model: 'Hero Splendor Plus',
      fuelCapacity: 9.5,
      distance: 15.0,
      pricePerHour: 7.0,
    ),
    // 12. TVS Apache RTR 160 (Thương hiệu TVS)
    Moto(
      id: '012',
      model: 'TVS Apache RTR 160',
      fuelCapacity: 12.0,
      distance: 20.0,
      pricePerHour: 11.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: motos.length,
          itemBuilder: (context, index){
            return MotoCard(moto: motos[index]);
          },
      ),
    );
  }
}
