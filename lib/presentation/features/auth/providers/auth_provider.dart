import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final authProvider = NotifierProvider<AuthNotifier, bool>(() {
  return AuthNotifier();
});

class AuthNotifier extends Notifier<bool> {
  static const String _authBox = 'auth_box';
  static const String _sessionKey = 'is_logged_in';

  @override
  bool build() {
    // This replaces the constructor and automatically sets the initial state
    final box = Hive.box(_authBox);
    return box.get(_sessionKey, defaultValue: false);
  }

  Future<void> login(String email, String password) async {
    // Mock network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a mock setup, any valid email/password passes
    final box = Hive.box(_authBox);
    await box.put(_sessionKey, true);
    state = true;
  }

  Future<void> logout() async {
    final box = Hive.box(_authBox);
    await box.put(_sessionKey, false);
    state = false;
  }
}