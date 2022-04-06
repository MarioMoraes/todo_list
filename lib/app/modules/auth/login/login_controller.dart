import 'package:flutter_todolist/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todolist/app/exceptions/auth_exception.dart';
import 'package:flutter_todolist/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('User Or Password Wrong!');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgot(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      await _userService.forgot(email);

      infoMessage = 'An Email Has Been Sent To Your Mailbox';
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('Error Login With Google');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
