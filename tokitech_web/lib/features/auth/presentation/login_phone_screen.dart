import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/locale_controller.dart';
import '../../../core/widgets/localized_text.dart';
import '../application/auth_controller.dart';
import '../application/auth_state.dart';

class LoginPhoneScreen extends ConsumerStatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  ConsumerState<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends ConsumerState<LoginPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '+91');

  @override
  void initState() {
    super.initState();
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.status == AuthStatus.codeSent && mounted) {
        context.go('/otp');
      } else if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Unknown error')),
        );
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final localeController = ref.watch(localeControllerProvider.notifier);
    final currentLocale = ref.watch(localeControllerProvider);

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
            constraints: const BoxConstraints(maxWidth: 960),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        LocalizedText(
                          'Staff Portal Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        LocalizedText(
                          'Access attendance, grades, fleet, and more from a single control panel.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(32),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const LocalizedText(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SegmentedButton<Locale>(
                                  segments: const [
                                    ButtonSegment(value: Locale('en'), label: Text('EN')),
                                    ButtonSegment(value: Locale('te'), label: Text('TE')),
                                  ],
                                  selected: {currentLocale},
                                  onSelectionChanged: (value) {
                                    localeController.setLocale(value.first);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const LocalizedText(
                              'Enter your registered mobile number to receive a one-time password.',
                              style: TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Mobile Number',
                                prefixIcon: Icon(Icons.phone_outlined),
                              ),
                              validator: (value) {
                                final text = value ?? '';
                                if (text.isEmpty) {
                                  return 'Please enter a mobile number';
                                }
                                if (text.length < 10) {
                                  return 'Enter a valid mobile number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: FilledButton(
                                onPressed: authState.isLoading ? null : _submit,
                                child: authState.isLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : const LocalizedText('Send OTP'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const LocalizedText(
                              'Need help? Contact your school administrator to update your registered mobile number.',
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final phone = _phoneController.text.trim();
    ref.read(authControllerProvider.notifier).sendOtp(phone);
  }
}
