import 'package:flutter/material.dart';
import 'package:rentapp/data/models/moto_model.dart';

class PaymentPage extends StatefulWidget {
  final Moto moto;

  const PaymentPage({super.key, required this.moto});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPaid = false; // Trạng thái thanh toán

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Model: ${widget.moto.model}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Rental Price per Hour: \$${widget.moto.pricePerHour.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Status: ${widget.moto.status}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (!_isPaid) // Hiển thị nút thanh toán nếu chưa thanh toán
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPaid = true; // Cập nhật trạng thái thanh toán
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment successful!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Pay Now'),
              ),
            if (_isPaid)
              const Text(
                'Payment Completed!',
                style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}