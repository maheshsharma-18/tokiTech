import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._repository) : super(AuthState.initial()) {
    _userSub = _repository.userChanges.listen(_handleUserUpdate);
  }

  final AuthRepository _repository;
  late final StreamSubscription<User?> _userSub;

  Future<void> sendOtp(String phoneNumber) async {
    state = state.copyWith(status: AuthStatus.sendingCode, errorMessage: null);
    try {
      final session = await _repository.sendOtp(phoneNumber);
      state = state.copyWith(
        status: AuthStatus.codeSent,
        session: session,
      );
    } catch (error) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> verifyOtp(String smsCode) async {
    final session = state.session;
    if (session == null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'No OTP session found. Please request a new code.',
      );
      return;
    }

    state = state.copyWith(status: AuthStatus.verifying, errorMessage: null);
    try {
      final credential = await _repository.verifyOtp(session, smsCode);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: credential.user,
      );
    } catch (error) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = AuthState.initial();
  }

  void _handleUserUpdate(User? user) {
    if (user == null) {
      state = AuthState.initial();
    } else {
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    }
  }

  @override
  void dispose() {
    _userSub.cancel();
    super.dispose();
  }
}
