import 'package:flutter/material.dart';
import 'profile_page.dart'; 
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Trang Chủ', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tìm kiếm', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
// --- Kết thúc Widget giữ chỗ ---

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Biến để lưu vị trí (index) của tab đang được chọn
  int _selectedIndex = 0;

  // Danh sách các trang sẽ được hiển thị tương ứng với mỗi tab
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),    // Trang cho tab thứ nhất (index 0)
    const SearchPage(),  // Trang cho tab thứ hai (index 1)
  ];

  // Hàm được gọi khi người dùng nhấn vào một tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật lại vị trí tab được chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body sẽ hiển thị trang tương ứng với tab được chọn
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Đây là nơi bạn định nghĩa thanh menu dưới cùng
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Hồ sơ',
          ),
        ],
        currentIndex: _selectedIndex, // Tab đang được chọn
        selectedItemColor: const Color(0xFF388E3C), // Màu của tab được chọn
        unselectedItemColor: Colors.grey, // Màu của tab không được chọn
        onTap: _onItemTapped, // Hàm xử lý khi nhấn vào tab
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
