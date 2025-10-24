import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; 

class MapPickerScreen extends StatefulWidget {
  final LatLng? initialLocation;
  
  const MapPickerScreen({
    super.key,
    this.initialLocation,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  // Biến để lưu vị trí đã chọn
  LatLng? _pickedLocation;
  
  // Vị trí mặc định để hiển thị bản đồ lúc đầu (TP.HCM)
  final LatLng _defaultPosition = const LatLng(10.762622, 106.660172);

  @override
  void initState() {
    super.initState();
    // Nếu có initialLocation thì dùng, không thì dùng mặc định
    _pickedLocation = widget.initialLocation;
  }

  // Hàm được gọi khi người dùng nhấn vào bản đồ
  void _selectLocation(TapPosition tapPosition, LatLng position) {
    setState(() {
      _pickedLocation = position;
      print('Selected location: ${position.latitude}, ${position.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn vị trí của xe'),
        actions: [
          // Nút check chỉ sáng lên khi người dùng đã chọn một vị trí
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    // Trả về tọa độ LatLng đã chọn khi nhấn nút
                    Navigator.of(context).pop(_pickedLocation);
                  },
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: widget.initialLocation ?? _defaultPosition,
          initialZoom: 13.0,
          onTap: _selectLocation, // Gán hàm xử lý khi nhấn
        ),
        children: [
          // Lớp nền của bản đồ, lấy từ OpenStreetMap
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app', // Thay bằng tên package của bạn
          ),
          
          // Lớp hiển thị Marker
          if (_pickedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _pickedLocation!,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}