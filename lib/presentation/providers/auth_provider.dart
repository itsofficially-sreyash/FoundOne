import 'package:flutter/widgets.dart';
import 'package:found_one/domain/reopsitories/auth_repository.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  phoneVerificationSent,
  phoneVerificationFailed,
  otpVerificationLoading,
  otpVerificationFailed,
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);
}
