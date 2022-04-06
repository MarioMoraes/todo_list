import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todolist/app/core/navigator/todo_list_navigator.dart';
import 'package:flutter_todolist/app/repositories/user_repository.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth,
        _userRepository = userRepository;

  Future<void> logout() => _userRepository.logout();
  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
