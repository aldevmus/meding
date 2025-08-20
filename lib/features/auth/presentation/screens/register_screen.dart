import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:dotted_border/dotted_border.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/features/auth/services/auth_service.dart';

import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:meding_app/app/routes/app_router.dart';

enum AccountType { student, professor }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  final AuthService _authService = AuthService();

  bool _termsAccepted = false;

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _studentIdController = TextEditingController();

  final _dateController = TextEditingController();

  String? _selectedSpecialty;

  String? _selectedYear;

  AccountType _selectedAccountType = AccountType.student;

  String? _selectedGender;

  double _passwordStrength = 0;

  String _passwordStrengthText = '';

  Color _passwordStrengthColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength);

    _nameController.dispose();

    _emailController.dispose();

    _passwordController.dispose();

    _studentIdController.dispose();

    _dateController.dispose();

    super.dispose();
  }

  void _checkPasswordStrength() {
    final localizations = AppLocalizations.of(context);

    if (localizations == null) return;

    String password = _passwordController.text;

    setState(() {
      if (password.isEmpty) {
        _passwordStrength = 0;

        _passwordStrengthText = '';

        return;
      }

      double strength = 0;

      if (password.length >= 8) strength += 0.25;

      if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;

      if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;

      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password))
        strength += 0.25;

      _passwordStrength = strength;

      if (strength < 0.5) {
        _passwordStrengthColor = AppColors.error;

        _passwordStrengthText = localizations.passwordStrengthWeak;

      } else if (strength < 0.8) {
        _passwordStrengthColor = AppColors.warning;

        _passwordStrengthText = localizations.passwordStrengthMedium;
      } else {
        _passwordStrengthColor = AppColors.success;

        _passwordStrengthText = localizations.passwordStrengthStrong;
      }
    });
  }

  Future<void> _registerStudent() async {
    final localizations = AppLocalizations.of(context)!;

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(localizations.validatorGenderRequired),
          backgroundColor: AppColors.error));

      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.registerStudent(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        fullName: _nameController.text.trim(),
        studentId: _studentIdController.text.trim(),
        dateOfBirth: _dateController.text,
        specialty: _selectedSpecialty,
        year: _selectedYear,
        gender: _selectedGender,
      );

      if (user != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(localizations.accountCreatedSuccessfully),
            backgroundColor: AppColors.success));

        // نوجهه مباشرة لشاشة التفعيل بعد إنشاء الحساب
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRouter.verifyEmail, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = localizations.firebaseErrorGeneric;

      if (e.code == 'weak-password') {
        errorMessage = localizations.firebaseErrorWeakPassword;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = localizations.firebaseErrorEmailInUse;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage), backgroundColor: AppColors.error));
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

  String? _validateName(String? value) {
    final localizations = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return localizations.validatorFullNameHint;
    }

    final trimmedValue = value.trim();

    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    if (!nameRegExp.hasMatch(trimmedValue)) {
      return localizations.validatorFullNameInvalid;
    }

    // التحقق من وجود كلمتين على الأقل

    if (!trimmedValue.contains(' ') || trimmedValue.split(' ').length < 2) {
      return localizations.validatorFullNameInvalidFormat;
    }

    return null;
  }

  String? _validateStudentId(String? value) {
    final localizations = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty)
      return localizations.validatorStudentIdHint;

    final idRegExp = RegExp(r'^[0-9]+$');

    if (!idRegExp.hasMatch(value))
      return localizations.validatorStudentIdInvalid;

    return null;
  }

  String? _validatePassword(String? value) {
    final localizations = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return localizations.validatorPasswordHint;
    }

    if (value.length < 8 || value.length > 20) {
      return localizations.validatorPasswordLengthBetween;
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return localizations.validatorPasswordUppercase;
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return localizations.validatorPasswordLowercase;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return localizations.validatorPasswordNumber;
    }

    return null;
  }

  Future<void> _selectDate() async {
    final DateTime now = DateTime.now();

    final DateTime lastSelectableDate =
        DateTime(now.year - 17, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastSelectableDate,
      firstDate: DateTime(1980),
      lastDate: lastSelectableDate,
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);

        _formKey.currentState?.validate();
      });
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    if (!await launchUrl(url)) {/* Handle Error */}
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'admin@meding.app',
        query: 'subject=Professor/Admin%20Account%20Inquiry');

    if (!await launchUrl(emailLaunchUri)) {/* Handle Error */}
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(localizations.joinMeding,
                      style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isDarkMode
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary)),
                  const SizedBox(height: 8),
                  Text(localizations.chooseAccountType,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: secondaryTextColor)),
                  const SizedBox(height: 24),
                  _buildTabSwitcher(isDarkMode, localizations),
                  const SizedBox(height: 24),
                  if (_selectedAccountType == AccountType.student)
                    _buildStudentForm(isDarkMode, localizations)
                  else
                    _buildProfessorTab(theme, localizations, isDarkMode),
                  const SizedBox(height: 24),
                  _buildLoginLink(theme, localizations, secondaryTextColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabSwitcher(bool isDarkMode, AppLocalizations localizations) {
    final Color inactiveTextColor =
        isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkSurface : AppColors.lightBg1,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  setState(() => _selectedAccountType = AccountType.student),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: _selectedAccountType == AccountType.student
                        ? AppColors.primaryBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(localizations.student,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _selectedAccountType == AccountType.student
                            ? Colors.white
                            : inactiveTextColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  setState(() => _selectedAccountType = AccountType.professor),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: _selectedAccountType == AccountType.professor
                        ? AppColors.primaryBlue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(localizations.professorAdmin,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _selectedAccountType == AccountType.professor
                            ? Colors.white
                            : inactiveTextColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getYearsForSpecialty(
      String? specialty, AppLocalizations localizations) {
    if (specialty == null) return [];

    int numberOfYears = (specialty == localizations.specialtyMedicine) ? 7 : 6;

    final yearMap = {
      1: localizations.year1,
      2: localizations.year2,
      3: localizations.year3,
      4: localizations.year4,
      5: localizations.year5,
      6: localizations.year6,
      7: localizations.year7,
    };

    return List.generate(numberOfYears, (index) => yearMap[index + 1]!);
  }

  Widget _buildStudentForm(bool isDarkMode, AppLocalizations localizations) {
    final theme = Theme.of(context);

    final Color secondaryTextColor =
        isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final List<String> availableYears =
        _getYearsForSpecialty(_selectedSpecialty, localizations);

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

    final bool isButtonEnabled = !_isLoading && _termsAccepted;

    // --- [الإصلاح 2]: تم تعديل طريقة بناء الزر ---

    Widget createAccountButton;

    if (isButtonEnabled) {
      createAccountButton = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.3),
              blurRadius: 15,
              spreadRadius: -2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,

              foregroundColor: Colors.white,

              padding: const EdgeInsets.symmetric(vertical: 18),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),

              elevation: 0, // نلغي ظل الزر نفسه لنعتمد على ظل الـ Container
            ),
            onPressed: _registerStudent,
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 3))
                : Text(localizations.createStudentAccount,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      );
    } else {
      // هذا هو شكل الزر وهو معطل (بدون ظل)

      createAccountButton = SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: null,
          child: Text(localizations.createStudentAccount,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              controller: _nameController,
              decoration: inputDecoration(localizations.fullName),
              validator: _validateName),

          const SizedBox(height: 16),

          TextFormField(
              controller: _emailController,
              decoration: inputDecoration(localizations.email),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => (v == null || v.isEmpty || !v.contains('@'))
                  ? localizations.validatorEmailInvalid
                  : null),

          const SizedBox(height: 16),

          TextFormField(
              controller: _passwordController,
              decoration: inputDecoration(localizations.password),
              obscureText: true,
              validator: _validatePassword),

          const SizedBox(height: 8),

          if (_passwordController.text.isNotEmpty)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor: Colors.grey.shade300,
                      color: _passwordStrengthColor,
                      minHeight: 6)),
              const SizedBox(height: 4),
              Text('${localizations.passwordStrength}: $_passwordStrengthText',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: _passwordStrengthColor)),
            ]),

          const SizedBox(height: 16),

          TextFormField(
              controller: _studentIdController,
              decoration: inputDecoration(localizations.studentId),
              keyboardType: TextInputType.number,
              validator: _validateStudentId),

          const SizedBox(height: 16),

          TextFormField(
              controller: _dateController,
              decoration: inputDecoration(localizations.dateOfBirth),
              readOnly: true,
              onTap: _selectDate,
              validator: (v) {
                if (v == null || v.isEmpty)
                  return localizations.validatorDateRequired;

                final selectedDate = DateTime.parse(v);

                final cutoffDate = DateTime(DateTime.now().year - 17,
                    DateTime.now().month, DateTime.now().day);

                if (selectedDate.isAfter(cutoffDate))
                  return localizations.validatorAgeRequirement;

                return null;
              }),

          const SizedBox(height: 16),

          Text(localizations.gender,
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: secondaryTextColor)),

          const SizedBox(height: 8),

          _buildGenderPicker(isDarkMode, localizations),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
              decoration: inputDecoration(localizations.chooseSpecialty),
              isExpanded: true,
              value: _selectedSpecialty,
              hint: Text(localizations.chooseSpecialty,
                  style: TextStyle(color: secondaryTextColor)),
              validator: (v) =>
                  v == null ? localizations.validatorSpecialtyRequired : null,
              onChanged: (v) {
                setState(() {
                  _selectedSpecialty = v;
                  _selectedYear = null;
                });
              },
              items: [
                localizations.specialtyMedicine,
                localizations.specialtyDentistry,
                localizations.specialtyPharmacy
              ]
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList()),

          const SizedBox(height: 16),

          Visibility(
              visible: _selectedSpecialty != null,
              child: DropdownButtonFormField<String>(
                  decoration: inputDecoration(localizations.chooseYear),
                  isExpanded: true,
                  value: _selectedYear,
                  hint: Text(localizations.chooseYear,
                      style: TextStyle(color: secondaryTextColor)),
                  validator: (v) => _selectedSpecialty != null && v == null
                      ? localizations.validatorYearRequired
                      : null,
                  onChanged: (v) => setState(() => _selectedYear = v),
                  items: availableYears
                      .map((String value) => DropdownMenuItem<String>(
                          value: value, child: Text(value)))
                      .toList())),

          const SizedBox(height: 16),

          _buildTermsAndConditions(theme, secondaryTextColor),

          const SizedBox(height: 24),

          createAccountButton, // --- تم وضع الزر المعدل هنا ---
        ],
      ),
    );
  }

  Widget _buildGenderPicker(bool isDarkMode, AppLocalizations localizations) {
    final Color secondaryTextColor =
        isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      children: [
        Expanded(
            child: GestureDetector(
                onTap: () => setState(() => _selectedGender = 'male'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: _selectedGender == 'male'
                          ? AppColors.primaryBlue
                          : (isDarkMode
                              ? AppColors.darkInputBg
                              : AppColors.lightInputBg),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: _selectedGender == 'male'
                              ? AppColors.primaryBlue
                              : (isDarkMode
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder),
                          width: 1)),
                  child: Text(localizations.male,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedGender == 'male'
                              ? Colors.white
                              : secondaryTextColor)),
                ))),
        const SizedBox(width: 16),
        Expanded(
            child: GestureDetector(
                onTap: () => setState(() => _selectedGender = 'female'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: _selectedGender == 'female'
                          ? AppColors.primaryBlue
                          : (isDarkMode
                              ? AppColors.darkInputBg
                              : AppColors.lightInputBg),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: _selectedGender == 'female'
                              ? AppColors.primaryBlue
                              : (isDarkMode
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder),
                          width: 1)),
                  child: Text(localizations.female,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedGender == 'female'
                              ? Colors.white
                              : secondaryTextColor)),
                ))),
      ],
    );
  }

  Widget _buildTermsAndConditions(ThemeData theme, Color secondaryTextColor) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
                value: _termsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    _termsAccepted = value ?? false;
                  });
                },
                activeColor: AppColors.primaryBlue)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: secondaryTextColor),
              children: [
                TextSpan(text: '${localizations.iAgreeTo} '),
                TextSpan(
                    text: localizations.termsOfUse,
                    style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL('https://meding.app/terms')),
                TextSpan(text: ' ${localizations.and} '),
                TextSpan(
                    text: localizations.privacyPolicy,
                    style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL('https://meding.app/privacy')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfessorTab(
      ThemeData theme, AppLocalizations localizations, bool isDarkMode) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: AppColors.primaryBlue.withValues(alpha: 0.4),
        strokeWidth: 2,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.primaryBlueAccent.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Text(localizations.specialRegistration,
              style: theme.textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(localizations.specialRegistrationInfo,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary)),
          const SizedBox(height: 16),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: _launchEmail,
              child: Text(localizations.contactAdmin)),
        ]),
      ),
    );
  }

  Widget _buildLoginLink(ThemeData theme, AppLocalizations localizations,
      Color secondaryTextColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(localizations.alreadyHaveAccount,
            style: TextStyle(color: secondaryTextColor)),
        TextButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacementNamed(AppRouter.login);
              }
            },
            child: Text(localizations.loginNow,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue))),
      ],
    );
  }
}
