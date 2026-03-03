import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Đảm bảo đường dẫn import này chính xác với vị trí file main_page.dart của bạn
import 'package:rentapp/features/user_main_page.dart';
import 'package:rentapp/features/auth/domain/entities/user_entity.dart';

class OnboardingPage extends StatelessWidget {
  final UserEntity user;
  const OnboardingPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold phải là câu lệnh duy nhất được trả về ở đây
    return Scaffold(
      appBar: AppBar(
        title: Text(  
          'Xin chào, ${user.name}!',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color(0xFFE8F5E9),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // Thêm padding cho đẹp hơn
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Renting easily. \nEnjoy your travel!',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Choose your favorite motobike for renting \nExperience the travel with a lower price',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 32), // Tăng khoảng cách
                  SizedBox(
                    width: double.infinity, // Cho nút rộng hết cỡ
                    height: 54,
                    child: ElevatedButton(
                      // SỬA Ở ĐÂY
                      onPressed: () {
                        // Thay thế trang hiện tại bằng MainPage
                        // Người dùng sẽ không thể quay lại trang onboarding
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            // Truyền thông tin user sang MainPage
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Let\'s go!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}