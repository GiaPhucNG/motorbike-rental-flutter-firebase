import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motorbike_rental_app/presentation/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';




class DatabaseMethods{
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance.collection("users").add(userInfoMap);
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  registration() async {
    if (passwordController.text.isNotEmpty &&  nameController.text.isNotEmpty && emailController.text.isNotEmpty){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password );
        Map<String, dynamic> userInfoMap = {
          "name": nameController.text,
          "email": emailController.text,
        };
        await DatabaseMethods().addUserDetails(userInfoMap);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green, content: Text("Registered successfully", style: TextStyle(fontSize: 16),),));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingPage()));
      } on FirebaseAuthException catch (e){
        if (e.code == 'weak-password'){
          print("The password provided is too weak.");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("The password provided is too weak.", style: TextStyle(fontSize: 16),),));
        } else if (e.code == 'email-already-in-use'){
          print("The account already exists for that email.");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text("The account already exists for that email.", style: TextStyle(fontSize: 16),),));
        }
      } catch (e){
        print(e);
      }
    }

  }






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
                const Text("Create Account!", style: TextStyle( color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
                const Text("Start your journey today!", style: TextStyle( color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),),
                const SizedBox(height: 60),
                // 🔹 Hộp nhập name với hiệu ứng kính mờ
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), border: Border.all(color: Colors.white54), borderRadius: BorderRadius.circular(30),),
                      child: TextField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: 'Enter your name', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 🔹 Hộp nhập email với hiệu ứng kính mờ
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), border: Border.all(color: Colors.white54), borderRadius: BorderRadius.circular(30),),
                      child: TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: 'Enter your email', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none,),
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
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: 'Enter your password', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                // 🔹 Nút đăng ký
                GestureDetector(
                  onTap: (){
                    if (passwordController.text != "" && nameController.text != "" && emailController.text != ""){
                      setState(() {
                        email = emailController.text.trim();
                        name = nameController.text.trim();
                        password = passwordController.text.trim();
                      });
                    }
                    registration();
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(30),),
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
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
