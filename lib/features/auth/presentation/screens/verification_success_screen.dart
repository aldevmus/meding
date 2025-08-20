import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meding_app/l10n/generated/app_localizations.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                'assets/lottie/success_animation.lottie', // تأكد أن لديك أنيميشن بهذا الاسم
                width: 150,
                height: 150,
                repeat: false,
              ),
              const SizedBox(height: 20),
              Text(l10n.successTitle, textAlign: TextAlign.center, style: theme.textTheme.displayLarge),
              const SizedBox(height: 16),
              Text(l10n.successBody, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                },
                child: Text(l10n.ctaStartLearning),
              ),
            ],
          ),
        ),
      ),
    );
  }
}