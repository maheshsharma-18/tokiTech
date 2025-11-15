import 'package:firebase_auth/firebase_auth.dart';

import '../data/auth_session.dart';

enum AuthStatus { idle, sendingCode, codeSent, verifying, authenticated, error }

class AuthState {
  const AuthState({
    required this.status,
    this.session,
    this.errorMessage,
    this.user,
  });

  factory AuthState.initial() => const AuthState(status: AuthStatus.idle);

  final AuthStatus status;
  final AuthSession? session;
  final String? errorMessage;
  final User? user;

  bool get isLoading => status == AuthStatus.sendingCode || status == AuthStatus.verifying;

  AuthState copyWith({
    AuthStatus? status,
    AuthSession? session,
    String? errorMessage,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: session ?? this.session,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}
