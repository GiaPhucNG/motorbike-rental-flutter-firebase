import 'dart:ui';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền
          Image.asset('assets/bg.png', height: double.infinity, width: double.infinity,fit: BoxFit.cover),
          // Lớp mờ phủ toàn bộ màn hình
          Container(color: Colors.black.withValues(alpha: 0.6)),

          // Nội dung chính
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 36.0, right: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome!", style: TextStyle( color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
                const Text("Start your journey today!", style: TextStyle( color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),),
                const SizedBox(height: 60),
                // 🔹 Hộp nhập email với hiệu ứng kính mờ
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), border: Border.all(color: Colors.white54), borderRadius: BorderRadius.circular(30),),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(hintText: 'Enter your email', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 🔹 Hộp nhập mật khẩu
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), border: Border.all(color: Colors.white54), borderRadius: BorderRadius.circular(30),),
                      child: const TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(hintText: 'Enter your password', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color.fromARGB(255, 196, 76, 32),),
                  child: const Center(
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(padding: EdgeInsets.all(8.0), child: Divider(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png', height: 50, width: 50, fit: BoxFit.cover),
                    const SizedBox(width: 20),
                    Image.asset('assets/facebook.png', height: 50, width: 50, fit: BoxFit.cover),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
