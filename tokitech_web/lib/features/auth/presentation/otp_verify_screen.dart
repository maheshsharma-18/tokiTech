import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/localized_text.dart';
import '../application/auth_controller.dart';
import '../application/auth_state.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated && mounted) {
        context.go('/admin');
      } else if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF001F3F), Color(0xFF013A63)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              margin: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LocalizedText(
                        'Enter OTP',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      const LocalizedText(
                        'We have sent a 6-digit code to your registered mobile number.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          labelText: 'One-Time Password',
                          counterText: '',
                        ),
                        validator: (value) {
                          final text = value ?? '';
                          if (text.length != 6) {
                            return 'Enter the 6-digit code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: authState.isLoading ? null : _verify,
                        child: authState.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const LocalizedText('Verify & Continue'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: authState.isLoading
                            ? null
                            : () {
                                context.go('/login');
                              },
                        child: const LocalizedText('Use a different number'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verify() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(authControllerProvider.notifier).verifyOtp(_otpController.text.trim());
  }
}
