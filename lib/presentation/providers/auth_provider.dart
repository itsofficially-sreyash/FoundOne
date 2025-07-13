import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:found_one/domain/entities/user_entity.dart';
import 'package:found_one/domain/reopsitories/auth_repository.dart';

enum AuthState {
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

  //State variables
  AuthState _authState = AuthState.initial;
  UserEntity? _currentUser;
  String? _verificationId;
  String? _phoneNumber;
  String? _userName;
  String? _errorMessage;
  int? _resendToken;

  //Getters
  AuthState get authState => _authState;
  UserEntity? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading =>
      _authState == AuthState.loading ||
      _authState == AuthState.otpVerificationLoading;

  //Initializing auth state
  Future<void> initializeAuth() async {
    try {
      _setAuthState(AuthState.loading);

      final User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await _fetchUserData(firebaseUser.uid);
        _setAuthState(AuthState.authenticated);
      } else {
        _setAuthState(AuthState.unauthenticated);
      }
    } catch (e) {
      _setError("Failed to initialize authentication: ${e.toString()}");
      _setAuthState(AuthState.unauthenticated);
    }
  }

  //send OTP to phone number
  Future<void> sendOtp(String phoneNumber, String name) async {
    try {
      _setAuthState(AuthState.loading);
      _phoneNumber = phoneNumber;
      _userName = name;
      _clearError();

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          //auto verification
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          _handleVerificationFailed(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          _setAuthState(AuthState.phoneVerificationSent);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      _setError("Failed to send OTP: ${e.toString()}");
      _setAuthState(AuthState.phoneVerificationFailed);
    }
  }

  //verify otp
  Future<void> verifyOtp(String smsCode) async {
    try {
      _setAuthState(AuthState.otpVerificationLoading);
      _clearError();

      if (_verificationId == null) {
        throw Exception("Verification Id not found. Please try again.");
      }

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      await _signInWithCredential(credential);
    } catch (e) {
      _setError("Invalid OTP. Please try again");
      _setAuthState(AuthState.otpVerificationFailed);
    }
  }

  //resend otp
  Future<void> resendOtp() async {
    if (_phoneNumber != null && _userName != null) {
      await sendOtp(_phoneNumber!, _userName!);
    }
  }

  //fetch user data
  Future<void> _fetchUserData(String uid) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;

        _currentUser = UserEntity(
          id: data["id"],
          name: data["name"],
          phoneNumber: data["phoneNumber"],
          createdAt: (data["createdAt"] as Timestamp).toDate(),
        );
      }
    } catch (e) {
      throw Exception("Failed to fetch user data: ${e.toString()}");
    }
  }

  //sign in with credential
  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (userCredential != null) {
        await _createOrUpdateUserProfile(userCredential.user!);
        _setAuthState(AuthState.authenticated);
      }
    } catch (e) {
      _setError("Failed to authenticate: ${e.toString()}");
      _setAuthState(AuthState.unauthenticated);
    }
  }

  //create or update user profile in firestore
  Future<void> _createOrUpdateUserProfile(User firebaseUser) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        final userData = {
          "id": firebaseUser.uid,
          "name": _userName ?? "Unkown",
          "phoneNumber": _phoneNumber ?? firebaseUser.phoneNumber ?? "",
          "createdAt": FieldValue.serverTimestamp(),
        };

        await userDoc.set(userData);
      }

      await _fetchUserData(firebaseUser.uid);
    } catch (e) {
      throw Exception("Failed to save user profile: ${e.toString()}");
    }
  }

  //sign out
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // _currentUser = null;
      // _verificationId = null;
      // _phoneNumber = null;
      // _userName = null;
      // _clearError();
      _resetState();
      _setAuthState(AuthState.unauthenticated);
    } catch (e) {
      _setError("Failed to sign out: ${e.toString()}");
    }
  }

  //Helper methods
  void _setAuthState(AuthState state) {
    _authState = authState;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  //handle failed verification
  void _handleVerificationFailed(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case "invalid-phone-number":
        errorMessage = "Invalid phone number";
        break;

      case "too-many-requests":
        errorMessage = "Too many requests. Please try again later";
        break;

      case "operation-not-allowed":
        errorMessage = "Phone authentication is not enabled";
        break;

      default:
        errorMessage = "Verification failed: ${e.message}";
    }
    _setError(errorMessage);
    _setAuthState(AuthState.phoneVerificationFailed);
  }

  //reset state for new authentication attempt
  void _resetState() {
    _authState = AuthState.initial;
    _verificationId = null;
    _phoneNumber = null;
    _userName = null;
    _errorMessage = null;
    _resendToken = null;
    notifyListeners();
  }
}
