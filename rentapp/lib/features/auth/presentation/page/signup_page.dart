import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentation/pages/onboarding_page.dart';
import 'package:rentapp/features/auth/presentation/page/login_page.dart';
import 'dart:ui';

// BLoC
import 'package:rentapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rentapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:rentapp/features/auth/presentation/bloc/auth_state.dart';

// Widgets
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_text.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _performRegistration() {
    // Kiểm tra các trường có được điền đầy đủ không
    if (nameController.text.trim().isEmpty) {
      _showSnackBar("Vui lòng nhập họ tên.", Colors.orange);
      return;
    }

    if (emailController.text.trim().isEmpty) {
      _showSnackBar("Vui lòng nhập email.", Colors.orange);
      return;
    }

    if (passwordController.text.isEmpty) {
      _showSnackBar("Vui lòng nhập mật khẩu.", Colors.orange);
      return;
    }

    if (passwordController.text.length < 6) {
      _showSnackBar("Mật khẩu phải có ít nhất 6 ký tự.", Colors.orange);
      return;
    }

    // Kiểm tra mật khẩu có khớp không
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar("Mật khẩu không khớp.", Colors.red);
      return;
    }

    // Gửi event đến BLoC để xử lý logic đăng ký
    context.read<AuthBloc>().add(SignUpEvent(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    ));
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message, style: const TextStyle(fontSize: 16)),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            _showSnackBar(state.message, Colors.red);
          } else if (state is AuthAuthenticated) {
            _showSnackBar("Đăng ký thành công!", Colors.green);
            // Chuyển hướng sau khi đăng ký thành công
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OnboardingPage(user: state.user as dynamic),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Nền gradient
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)],
                  ),
                ),
              ),
              // Ảnh minh họa
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
              // Form đăng ký
              Positioned(
                top: screenSize.height * 0.3,
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Start your eco-friendly journey today!",
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 30),
                            NeumorphicTextField(
                              controller: nameController,
                              hintText: 'Full Name',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 20),
                            NeumorphicTextField(
                              controller: emailController,
                              hintText: 'Email',
                              icon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 20),
                            NeumorphicTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              icon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _obscurePassword,
                              onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            const SizedBox(height: 20),
                            NeumorphicTextField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm Password',
                              icon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _obscureConfirmPassword,
                              onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                            ),
                            const SizedBox(height: 30),
                            
                            // Hiển thị loading hoặc nút bấm tùy theo state
                            if (state is AuthLoading)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF2E7D32),
                                ),
                              )
                            else
                              NeumorphicButton(
                                onTap: _performRegistration,
                                text: "Sign Up",
                              ),
                            
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Color(0xFF2E7D32),
                                      fontWeight: FontWeight.bold,
                                    ),
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
          );
        },
      ),
    );
  }
}