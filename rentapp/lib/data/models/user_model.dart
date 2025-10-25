import 'package:rentapp/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.role,
    super.photoURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? json['Id'] ?? '',
      name: json['name'] ?? json['Name'] ?? '',
      email: json['email'] ?? json['Email'] ?? '',
      role: json['role'] ?? 'user',
      photoURL: json['photoURL'] ?? json['Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'photoURL': photoURL,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      role: role,
      photoURL: photoURL,
    );
  }
}