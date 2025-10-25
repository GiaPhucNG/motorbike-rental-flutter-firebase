// lib/features/auth/presentation/bloc/auth_event.dart
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}