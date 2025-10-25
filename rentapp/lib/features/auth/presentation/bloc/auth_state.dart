// lib/features/auth/presentation/bloc/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:rentapp/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess({required this.user});
  @override
  List<Object> get props => [user];
}
class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({required this.message});
  @override
  List<Object> get props => [message];
}
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}