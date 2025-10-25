import 'package:rentapp/features/auth/domain/entities/user_entity.dart';
import 'package:rentapp/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}