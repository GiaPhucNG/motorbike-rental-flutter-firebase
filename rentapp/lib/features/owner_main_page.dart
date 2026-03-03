import 'package:flutter/material.dart';
import 'package:rentapp/features/auth/presentation/page/profile_page.dart';
import 'package:rentapp/features/moto/presentation/pages/moto_crud_screen.dart';

// THAY ĐỔI 2: Đổi tên class thành OwnerMainPage
class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

// Đổi tên state tương ứng
class _OwnerMainPageState extends State<OwnerMainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      // THAY ĐỔI 3: Thay thế MotoListScreen bằng MotoCrudScreen
      const MotoCrudScreen(), 
      ProfilePage(),     
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // THAY ĐỔI 4 (Tùy chọn): Cập nhật icon và label cho phù hợp
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note), // Icon quản lý
            label: 'Manage Moto', // Label rõ ràng hơn
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // Bạn có thể đổi màu cho Owner nếu muốn
        onTap: _onItemTapped,
      ),
    );
  }
}