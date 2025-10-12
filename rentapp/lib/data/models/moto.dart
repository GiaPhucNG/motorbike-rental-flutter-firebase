class Moto {
  final String id;              // ID duy nhất của xe (tự động tạo từ Firestore hoặc UUID)
  final String model;           // Kiểu xe (ví dụ: Vespa Justin Bieber, Honda CBR)
  final double fuelCapacity;    // Dung tích bình nhiên liệu (lít)
  final double distance;        // Quãng đường đã đi (km)
  final double pricePerHour;    // Giá thuê mỗi giờ (USD hoặc VND)

  Moto({required this.id, required this.model, required this.fuelCapacity, required this.distance, required this.pricePerHour});

}