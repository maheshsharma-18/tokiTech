import 'package:firebase_auth/firebase_auth.dart';

class AuthSession {
  const AuthSession({
    this.verificationId,
    this.resendToken,
    this.confirmationResult,
  });

  final String? verificationId;
  final int? resendToken;
  final ConfirmationResult? confirmationResult;
}
