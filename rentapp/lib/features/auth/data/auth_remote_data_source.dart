import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentapp/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final user = userCredential.user!;
    
    // Lấy thông tin user từ Firestore
    final userDoc = await firestore.collection('users').doc(user.uid).get();
    
    if (userDoc.exists) {
      return UserModel.fromJson({
        ...userDoc.data()!,
        'uid': user.uid,
      });
    }

    // Nếu không có trong Firestore, tạo từ Firebase Auth
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email!,
      role: 'user',
      photoURL: user.photoURL,
    );
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final user = userCredential.user!;

    final userModel = UserModel(
      uid: user.uid,
      name: name,
      email: email,
      role: 'user',
    );

    // Lưu thông tin user vào Firestore
    await firestore.collection('users').doc(user.uid).set(userModel.toJson());

    return userModel;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user!;

    final userDoc = firestore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    final userModel = UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email!,
      role: 'user',
      photoURL: user.photoURL,
    );

    if (!docSnapshot.exists) {
      await userDoc.set(userModel.toJson());
    }

    return userModel;
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}