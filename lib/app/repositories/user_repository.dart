import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> forgot(String email);
  Future<User?> loginGoogle();
  Future<void> logout();
  Future<void> updateUserName(String name);
}
