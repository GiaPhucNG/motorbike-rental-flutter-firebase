import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentapp/presentation/pages/onboarding_page.dart';
import 'package:rentapp/features/auth/presentation/page/signup_page.dart';
import 'package:rentapp/features/auth/presentation/page/forgotpassword_page.dart';
import 'package:rentapp/core/services/GoogleAuthService.dart';
// widget
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_text.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_button.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_icon_button.dart';

import 'dart:ui';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  Future<void> userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingPage(user: user!)),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message = 'Email không tồn tại. Vui lòng đăng ký tài khoản mới.';
          break;
        case 'wrong-password':
          message = 'Mật khẩu không chính xác. Vui lòng thử lại.';
          break;
        case 'invalid-email':
          message = 'Địa chỉ email không hợp lệ.';
          break;
        case 'user-disabled':
          message = 'Tài khoản này đã bị vô hiệu hóa.';
          break;
        case 'too-many-requests':
          message = 'Bạn đăng nhập sai quá nhiều lần. Vui lòng thử lại sau.';
          break;
        case 'network-request-failed':
          message = 'Không thể kết nối đến máy chủ. Kiểm tra lại Internet.';
          break;
        default:
          message = 'Đã xảy ra lỗi. Vui lòng thử lại.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(message,style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7),],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/eco_illustration.png',
              height: screenSize.height * 0.45, 
              width: screenSize.width,
              fit: BoxFit.cover, 
            ),
          ),

          Positioned(
            top: screenSize.height * 0.4, 
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), 
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all( color: Colors.white.withValues(alpha: 0.2), width: 1.5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white.withValues( alpha: 0.5),  Colors.white.withValues( alpha: 0.7), ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32), ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to continue your eco-friendly ride",
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),),

                        const SizedBox(height: 36),
                        NeumorphicTextField( controller: emailController, hintText: 'Email', icon: Icons.person_outline_rounded,),
                        const SizedBox(height: 20),
                        NeumorphicTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _isPasswordObscured,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute( builder: (context) => const ForgotPasswordPage()),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Color(0xFF388E3C), fontSize: 13, fontWeight: FontWeight.w500,),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        NeumorphicButton(onTap: userLogin,text: "Sign In",),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[400])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Or continue with",
                                style: TextStyle( color: Colors.grey[600], fontSize: 13)),
                            ),
                            Expanded(child: Divider(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NeumorphicIconButton(
                                icon: Icons.g_mobiledata,
                                iconColor: const Color(0xFFDB4437),
                                onTap: () async {
                                  User? user = await GoogleAuthService().signInWithGoogle();
                                  if (user != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => OnboardingPage(user: user)),
                                    );
                                  }
                                }),
                            const SizedBox(width: 24),
                            NeumorphicIconButton(
                                icon: Icons.facebook,
                                iconColor: const Color(0xFF1877F2),
                                onTap: () async {
                                  print("Facebook clicked");
                                  // Gọi đăng nhập Facebook ở đây
                                }),
                          ],
                        ),
                        const SizedBox(height: 20), 

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( "Don't have an account? ", style: TextStyle(color: Colors.grey[700]), ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute( builder: (context) => const SignUp()),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle( color: Color(0xFF2E7D32),fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
