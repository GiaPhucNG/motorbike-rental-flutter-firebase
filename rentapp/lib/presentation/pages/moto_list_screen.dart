import 'package:flutter/material.dart' hide SearchBar;
import 'package:rentapp/data/models/moto.dart';
import 'package:rentapp/presentation/widgets/filter_dialog.dart';
import 'package:rentapp/presentation/widgets/moto_card.dart';
import 'package:rentapp/presentation/widgets/search_bar.dart';

class MotoListScreen extends StatefulWidget {
    const MotoListScreen({super.key});

    @override
    _MotoListScreenState createState() => _MotoListScreenState();
  }

class _MotoListScreenState extends State<MotoListScreen> {
  final List<Moto> motos = [
    Moto(model: 'Honda Vision', fuelCapacity: 5.5, distance: 10.0, pricePerHour: 8.0,),
    Moto(model: 'Honda PCX 160', fuelCapacity: 8.0, distance: 15.0, pricePerHour: 10.0,),
    Moto(model: 'Yamaha Aerox 155', fuelCapacity: 5.5, distance: 20.0, pricePerHour: 12.0,),
    Moto(model: 'Yamaha MT-03', fuelCapacity: 14.0, distance: 25.0, pricePerHour: 15.0,),
    Moto(model: 'Vespa Sprint', fuelCapacity: 7.0, distance: 12.0, pricePerHour: 10.0,),
    Moto(model: 'Vespa GTS 300', fuelCapacity: 9.0, distance: 18.0, pricePerHour: 13.0,),
    Moto(model: 'Suzuki Gixxer', fuelCapacity: 12.0, distance: 30.0, pricePerHour: 14.0,),
    Moto(model: 'Suzuki Hayabusa', fuelCapacity: 21.0, distance: 40.0, pricePerHour: 20.0,),
    Moto(model: 'Kawasaki Ninja 250', fuelCapacity: 17.0, distance: 25.0, pricePerHour: 18.0,),
    Moto(model: 'Kawasaki Z900', fuelCapacity: 17.0, distance: 35.0, pricePerHour: 22.0,),
  ];

  List<Moto> filteredMotos = [];
  final TextEditingController _searchController = TextEditingController();
  String? _selectedPriceRange;

  @override
  void initState() {
    super.initState();
    filteredMotos = motos; // Khởi tạo danh sách lọc
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hàm lọc danh sách xe máy
  void _filterMotos(String query) {
    setState(() {
      filteredMotos = motos.where((moto) {
        // Tìm kiếm theo model
        final matchesQuery = query.isEmpty || moto.model.toLowerCase().contains(query.toLowerCase());

        // Lọc theo giá
        final matchesPrice = _selectedPriceRange == null ||
            (_selectedPriceRange == 'under_10' && moto.pricePerHour < 10.0) ||
            (_selectedPriceRange == '10_to_15' && moto.pricePerHour >= 10.0 && moto.pricePerHour <= 15.0) ||
            (_selectedPriceRange == 'over_15' && moto.pricePerHour > 15.0);

        return matchesQuery && matchesPrice;
      }).toList();
    });
  }

  // Hàm xóa từ khóa tìm kiếm
  void _clearSearch() {
    _searchController.clear();
    _filterMotos('');
  }

  // Hàm áp dụng bộ lọc
  void _applyFilter(String? priceRange) {
    setState(() {
      _selectedPriceRange = priceRange;
      _filterMotos(_searchController.text);
    });
  }

  // Hàm hiển thị dialog bộ lọc
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(
        selectedPriceRange: _selectedPriceRange,
        onApply: _applyFilter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorbike Rental'),
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm và nút lọc
          Row(
            children: [
              Expanded(
                child: SearchBar(
                  controller: _searchController,
                  onChanged: _filterMotos,
                  onClear: _clearSearch,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterDialog,
                tooltip: 'Filter by Price',
              ),
            ],
          ),
          // Danh sách xe máy
          Expanded(
            child: ListView.builder(
              itemCount: filteredMotos.length,
              itemBuilder: (context, index) {
                return MotoCard(moto: filteredMotos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
