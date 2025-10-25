// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_remote_data_source.dart';
import 'package:rentapp/features/auth/domain/entities/user_entity.dart';
import 'package:rentapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return userModel.toEntity();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi không xác định: $e');
    }
  }

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      return userModel.toEntity();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi không xác định: $e');
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final userModel = await remoteDataSource.signInWithGoogle();
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Đăng nhập Google thất bại: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } catch (e) {
      throw Exception('Đăng xuất thất bại: $e');
    }
  }

  Exception _handleFirebaseAuthException(FirebaseAuthException e) {
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
      case 'weak-password':
        message = 'Mật khẩu quá yếu.';
        break;
      case 'email-already-in-use':
        message = 'Email này đã được sử dụng.';
        break;
      default:
        message = 'Đã xảy ra lỗi: ${e.message}';
    }
    return Exception(message);
  }
}