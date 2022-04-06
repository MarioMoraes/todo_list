import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../exceptions/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'Email Already In Use! Try Another Email!');
        } else {
          throw AuthException(message: 'Use Your Account Google To Login');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro Register User');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Internal Error In Login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Password Dont Match');
      }
      throw AuthException(message: e.message ?? 'Internal Error In Login');
    }
  }

  @override
  Future<void> forgot(String email) async {
    try {
      final loginType = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginType.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginType.contains('google')) {
        throw AuthException(message: 'Use Your Account Google To Login');
      } else {
        throw AuthException(message: 'Internal Error');
      }
    } on PlatformException {
      throw AuthException(message: 'Error Reset Password');
    }
  }

  @override
  Future<User?> loginGoogle() async {
    List<String>? loginType;

    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginType =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginType.contains('password')) {
          throw AuthException(message: 'Use Email And Password To Login');
        } else {
          final googleAuth = await googleUser.authentication;
          final googleCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final userCredential =
              await _firebaseAuth.signInWithCredential(googleCredential);

          return userCredential.user;
        }
      }
    } on FirebaseException {
      throw AuthException(
          message: "Your Last Login Has With Provider ${loginType?.join(',')}");
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateUserName(String name) async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
