// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/features/moto/presentation/pages/moto_crud_screen.dart';
import 'package:rentapp/presentation/pages/onboarding_page.dart';
import 'package:rentapp/features/auth/presentation/page/signup_page.dart';
import 'package:rentapp/features/auth/presentation/page/forgotpassword_page.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_text.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_button.dart';
import 'package:rentapp/features/auth/presentation/widgets/neumorphic_icon_button.dart';
import 'package:rentapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rentapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:rentapp/features/auth/presentation/bloc/auth_state.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    context.read<AuthBloc>().add(
          SignInEvent(
            email: emailController.text,
            password: passwordController.text,
          ),
        );
  }

  void _handleGoogleSignIn() {
    context.read<AuthBloc>().add(SignInWithGoogleEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Chuyển sang trang chính sau khi đăng nhập thành công
            if (state.user.role == 'owner') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MotoCrudScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingPage(user: state.user),
                ),
              );
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Background gradient
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

            // Top illustration
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

            // Login form
            Positioned(
              top: screenSize.height * 0.4,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.5),
                          Colors.white.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40)),
                    ),
                    child: SingleChildScrollView(
                      padding:
                          const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome Back!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Sign in to continue your eco-friendly ride",
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),

                          const SizedBox(height: 36),

                          // Email field
                          NeumorphicTextField(
                            controller: emailController,
                            hintText: 'Email',
                            icon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 20),

                          // Password field
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

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFF388E3C),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Sign in button with loading state
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const CircularProgressIndicator();
                              }
                              return NeumorphicButton(
                                onTap: _handleSignIn,
                                text: "Sign In",
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          // Divider
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey[400])),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Or continue with",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 13),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.grey[400])),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Social login buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NeumorphicIconButton(
                                icon: Icons.g_mobiledata,
                                iconColor: const Color(0xFFDB4437),
                                onTap: _handleGoogleSignIn,
                              ),
                              const SizedBox(width: 24),
                              NeumorphicIconButton(
                                icon: Icons.facebook,
                                iconColor: const Color(0xFF1877F2),
                                onTap: () {
                                  print("Facebook clicked");
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Sign up link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
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
        ),
      ),
    );
  }
}