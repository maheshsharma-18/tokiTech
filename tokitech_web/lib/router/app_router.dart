import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/admin/presentation/admin_shell_screen.dart';
import '../features/auth/application/auth_controller.dart';
import '../features/auth/application/auth_state.dart';
import '../features/auth/presentation/login_phone_screen.dart';
import '../features/auth/presentation/otp_verify_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref.watch(authControllerProvider.notifier).stream),
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/otp';

      if (!isAuthenticated && !loggingIn) {
        return '/login';
      }

      if (isAuthenticated && loggingIn) {
        return '/admin';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPhoneScreen(),
      ),
      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) => const OtpVerifyScreen(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminShellScreen(),
      ),
    ],
  );
});

/// Helper bridge between Riverpod and GoRouter refresh signals.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
