import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

import 'package:meding_app/features/auth/services/auth_service.dart';

import 'package:meding_app/app/routes/app_router.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthService _authService = AuthService();
  Timer? _timer;
  bool _canResendEmail = false;
  int _countdown = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendCooldown();

    // ابدأ التحقق الدوري من حالة التفعيل
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      if (user?.emailVerified ?? false) {
        timer.cancel();
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil('/verification-success', (route) => false);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendCooldown() {
    _canResendEmail = false;
    _countdown = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        if (mounted) setState(() => _countdown--);
      } else {
        timer.cancel();
        if (mounted) setState(() => _canResendEmail = true);
      }
    });
  }

  Future<void> _resendEmail() async {
    if (!_canResendEmail) return;
    
    final l10n = AppLocalizations.of(context)!;
    try {
      await _authService.resendVerificationEmail();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.emailVerificationSent)));
      _startResendCooldown();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.firebaseErrorGeneric)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svgs/email_icon.svg', // تأكد أن لديك أيقونة بهذا الاسم
                    width: 48,
                    height: 48,
                    colorFilter: ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(l10n.verifyEmailTitle, textAlign: TextAlign.center, style: theme.textTheme.displayLarge),
              const SizedBox(height: 16),
              Text(
                '${l10n.verifyEmailBody} $currentUserEmail',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: _resendEmail,
                child: Text(
                  _canResendEmail
                      ? l10n.resendEmailButton
                      : l10n.resendEmailCountdown(_countdown),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
                },
                child: Text(l10n.backToSignIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}