class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? photoURL;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.photoURL,
  });

  bool get isOwner => role == 'owner';
  bool get isUser => role == 'user';
}
