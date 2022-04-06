import 'package:flutter/cupertino.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  bool _success = false;
  String? _error;

  bool get loading => _loading;
  bool get isSuccess => _success;
  bool get hasError => _error != null;
  String? get error => _error;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = error;

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }
}
