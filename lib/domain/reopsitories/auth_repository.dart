import 'package:found_one/domain/entities/user_entity.dart';

abstract class AuthRepository {
  //Phone verification flow
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    required Function() onVerificationCompleted,
  });

  //OTP verification
  Future<UserEntity?> verifyOtp({
    required String verificationId,
    required String otp,
  });

  //User Profile management
  Future<void> saveUserProfile({
    required String uid,
    required String name,
    required String phoneNumber,
  });

  Future<UserEntity?> getCurrentUser();

  //Session Management
  Future<bool> isUserLoggedIn();
  Future<void> signOut();

  //User data retrieval
  Future<UserEntity?> getUserProfile(String uid);

  //Stream for auth state changes
  Stream<UserEntity?> get authStateChanges;
}
