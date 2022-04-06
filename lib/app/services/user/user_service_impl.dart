import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_todolist/app/repositories/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  @override
  Future<void> forgot(String email) => _userRepository.forgot(email);

  @override
  Future<User?> googleLogin() => _userRepository.loginGoogle();

  @override
  Future<void> logout() => _userRepository.logout();

  @override
  Future<void> updateUserName(String name) =>
      _userRepository.updateUserName(name);
}
