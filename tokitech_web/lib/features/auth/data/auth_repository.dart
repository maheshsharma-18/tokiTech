import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'auth_session.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get userChanges => _auth.userChanges();

  Future<AuthSession> sendOtp(String phoneNumber) async {
    if (kIsWeb) {
      final confirmation = await _auth.signInWithPhoneNumber(phoneNumber);
      return AuthSession(confirmationResult: confirmation);
    }

    final completer = Completer<AuthSession>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        completer.complete(const AuthSession());
      },
      verificationFailed: (exception) {
        completer.completeError(exception);
      },
      codeSent: (verificationId, resendToken) {
        completer.complete(
          AuthSession(verificationId: verificationId, resendToken: resendToken),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );

    return completer.future;
  }

  Future<UserCredential> verifyOtp(AuthSession session, String smsCode) async {
    if (kIsWeb) {
      final result = session.confirmationResult;
      if (result == null) {
        throw StateError('Missing confirmation result for web verification.');
      }
      return result.confirm(smsCode);
    }

    final verificationId = session.verificationId;
    if (verificationId == null) {
      throw StateError('Verification ID is missing.');
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() => _auth.signOut();
}
