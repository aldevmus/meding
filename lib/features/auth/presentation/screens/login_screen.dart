import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/features/auth/presentation/screens/register_screen.dart';

import 'package:meding_app/features/auth/services/auth_service.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

import 'package:firebase_auth/firebase_auth.dart';

// TODO: قم باستيراد شاشة Home Screen عندما تصبح جاهزة

import 'package:meding_app/features/splash/presentation/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  bool _isForgotPassword = false;

  bool _isPasswordObscured = true;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _handleAuthAction() async {
    if (!_formKey.currentState!.validate()) return;

    if (_isForgotPassword) {
      await _sendResetEmail();
    } else {
      await _login();
    }
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    final localizations = AppLocalizations.of(context)!;

    try {
      final user = await _authService.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (user != null && mounted) {
        // TODO: استبدل `SplashScreen` بـ `HomeScreen` بعد إنشائها

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SplashScreen()));
      }
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(localizations.loginErrorInvalid),
          backgroundColor: AppColors.error));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(localizations.firebaseErrorGeneric),
          backgroundColor: AppColors.error));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _sendResetEmail() async {
    setState(() => _isLoading = true);

    final localizations = AppLocalizations.of(context)!;

    try {
      await _authService.sendPasswordResetEmail(
          email: _emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(localizations.passwordResetEmailSent),
          backgroundColor: AppColors.success));

      setState(() => _isForgotPassword = false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(localizations.userNotFound),
            backgroundColor: AppColors.error));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(localizations.firebaseErrorGeneric),
            backgroundColor: AppColors.error));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final localizations = AppLocalizations.of(context)!;

    final isDarkMode = theme.brightness == Brightness.dark;

    final Color secondaryTextColor =
        isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final systemUiOverlayStyle =
        isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    // --- [التعديل الأساسي]: تعريف ستايلات مشروطة حسب اللغة ---

    final String locale = localizations.localeName;

    // ستايل العنوان الرئيسي

    TextStyle titleStyle = theme.textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w800,
        color: isDarkMode
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary);

    if (locale == 'en' || locale == 'fr') {
      // تصغير حجم الخط للغات اللاتينية لأن خط Inter أعرض

      titleStyle = titleStyle.copyWith(fontSize: titleStyle.fontSize! * 0.85);
    }

    // ستايل العنوان الفرعي

    TextStyle subtitleStyle =
        theme.textTheme.bodyLarge!.copyWith(color: secondaryTextColor);

    if (locale == 'en' || locale == 'fr') {
      subtitleStyle =
          subtitleStyle.copyWith(fontSize: subtitleStyle.fontSize! * 0.95);
    }

    // ستايلات النص السفلي

    TextStyle bottomTextStyle =
        theme.textTheme.bodyMedium!.copyWith(color: secondaryTextColor);

    TextStyle bottomButtonTextStyle = theme.textTheme.bodyMedium!
        .copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryBlue);

    InputDecoration inputDecoration(String hintText) => InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: secondaryTextColor),
          filled: true,
          fillColor:
              isDarkMode ? AppColors.darkInputBg : const Color(0xFFF8FAFC),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color:
                      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color:
                      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 1)),
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: SvgPicture.asset(
                        'assets/svgs/meding_logo.svg',
                        height: 50,
                        colorFilter: ColorFilter.mode(
                            isDarkMode ? Colors.white : AppColors.logoCyan,
                            BlendMode.srcIn),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(localizations.welcomeBack,
                        style: titleStyle), // تطبيق الستايل المشروط

                    const SizedBox(height: 8),

                    Text(localizations.loginToContinue,
                        style: subtitleStyle), // تطبيق الستايل المشروط

                    const SizedBox(height: 32),

                    TextFormField(
                        controller: _emailController,
                        decoration: inputDecoration(localizations.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            (v == null || v.isEmpty || !v.contains('@'))
                                ? localizations.validatorEmailInvalid
                                : null),

                    const SizedBox(height: 20),

                    if (!_isForgotPassword)
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        decoration:
                            inputDecoration(localizations.password).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: secondaryTextColor),
                            onPressed: () => setState(() =>
                                _isPasswordObscured = !_isPasswordObscured),
                          ),
                        ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? localizations.validatorRequiredField
                            : null,
                      ),

                    const SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => setState(
                            () => _isForgotPassword = !_isForgotPassword),
                        child: Text(
                            _isForgotPassword
                                ? localizations.backToLogin
                                : localizations.forgotPassword,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryBlue
                                    .withValues(alpha: 0.3),
                                blurRadius: 15,
                                spreadRadius: -2,
                                offset: const Offset(0, 8))
                          ]),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  elevation: 0),
                              onPressed: _isLoading ? null : _handleAuthAction,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 3))
                                  : Text(
                                      _isForgotPassword
                                          ? localizations.resetPasswordLink
                                          : localizations.login,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)))),
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 2,
                        children: [
                          Text(localizations.noAccount,
                              style: bottomTextStyle), // تطبيق الستايل المشروط

                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4)), // تقليل الحشو لتقريب النص

                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen())),

                            child: Text(localizations.createOneNow,
                                style:
                                    bottomButtonTextStyle), // تطبيق الستايل المشروط
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
