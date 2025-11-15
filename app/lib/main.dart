import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    final isTelugu = _locale.languageCode == 'te';
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B5CE2)),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF3F4F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );

    final textTheme = isTelugu
        ? GoogleFonts.notoSansTeluguTextTheme(baseTheme.textTheme)
        : GoogleFonts.interTextTheme(baseTheme.textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('te')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: baseTheme.copyWith(textTheme: textTheme),
      home: LoginScreen(onChangeLocale: (loc) => setState(() => _locale = loc)),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onChangeLocale});
  final void Function(Locale) onChangeLocale;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  bool showOtp = false;

  @override
  void dispose() {
    phoneCtrl.dispose();
    otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 980;

            final twoPane = Row(
              children: [
                if (wide) Expanded(child: const _LeftPanel()),
                Expanded(
                  child: _RightPanel(
                    showOtp: showOtp,
                    phoneCtrl: phoneCtrl,
                    otpCtrl: otpCtrl,
                    onSendOtp: () => setState(() => showOtp = true),
                    onCancelOtp: () => setState(() { showOtp = false; otpCtrl.clear(); }),
                    onVerifyLogin: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${t.verifyLogin} (UI only)')),
                      );
                    },
                    onChangeSchool: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Change School (UI only)')),
                      );
                    },
                    onChangeLocale: widget.onChangeLocale,
                  ),
                ),
              ],
            );

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF7F8FF), Color(0xFFFEFEFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 820),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: twoPane,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LeftPanel extends StatelessWidget {
  const _LeftPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF2F4FF), Color(0xFFEFF3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 16, offset: const Offset(0, 8)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://images.unsplash.com/photo-1562774053-701939374585?auto=format&fit=crop&w=420&q=60',
                  width: 120, height: 120, fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.schoolName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              t.schoolTagline,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 48),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40, width: 40,
                  decoration: const BoxDecoration(color: Color(0xFFE9EDFF), shape: BoxShape.circle),
                  child: const Icon(Icons.apartment_rounded, color: Color(0xFF5B5CE2)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.trustedTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(t.trustedSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _RightPanel extends StatelessWidget {
  const _RightPanel({
    required this.showOtp,
    required this.phoneCtrl,
    required this.otpCtrl,
    required this.onSendOtp,
    required this.onCancelOtp,
    required this.onVerifyLogin,
    required this.onChangeSchool,
    required this.onChangeLocale,
    super.key,
  });

  final bool showOtp;
  final TextEditingController phoneCtrl;
  final TextEditingController otpCtrl;
  final VoidCallback onSendOtp;
  final VoidCallback onCancelOtp;
  final VoidCallback onVerifyLogin;
  final VoidCallback onChangeSchool;
  final void Function(Locale) onChangeLocale;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.welcome, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 32),

          Text(t.phoneNumber, style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 8),
          TextField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: t.phonePlaceholder,
              prefixIcon: const Icon(Icons.phone_iphone_outlined),
              prefixIconColor: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),

          if (showOtp) ...[
            Text(t.enterOtp, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 8),
            TextField(
              controller: otpCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: t.otpPlaceholder),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancelOtp,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(t.cancel),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: onVerifyLogin,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: const Color(0xFF5B5CE2),
                    ),
                    child: Text(t.verifyLogin),
                  ),
                ),
              ],
            ),
          ] else ...[
            FilledButton(
              onPressed: onSendOtp,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: const Color(0xFF5B5CE2),
              ),
              child: Text(t.sendOtp),
            ),
          ],

          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 16),

          TextButton.icon(
            onPressed: onChangeSchool,
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
            label: Text(t.changeSchool, style: const TextStyle(color: Colors.black87)),
          ),

          const Spacer(),

          Center(
            child: Wrap(
              spacing: 12,
              children: [
                _LangChip(
                  label: t.langEnglish,
                  selected: Localizations.localeOf(context).languageCode == 'en',
                  onTap: () => onChangeLocale(const Locale('en')),
                ),
                _LangChip(
                  label: t.langTelugu,
                  selected: Localizations.localeOf(context).languageCode == 'te',
                  onTap: () => onChangeLocale(const Locale('te')),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Center(
            child: Opacity(
              opacity: 0.8,
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  children: const [
                    TextSpan(text: 'Powered by '),
                    TextSpan(text: 'ToKi', style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  const _LangChip({required this.label, required this.selected, required this.onTap, super.key});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE9EDFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? const Color(0xFF5B5CE2) : Colors.black26),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF5B5CE2) : Colors.black87,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
