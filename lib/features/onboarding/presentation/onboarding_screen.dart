import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/features/auth/presentation/screens/login_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';

// OnboardingItem class remains the same

class OnboardingItem {
  final String lightImagePath;

  final String darkImagePath;

  final String title;

  final String description;

  OnboardingItem({
    required this.lightImagePath,
    required this.darkImagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // ... (Your methods like _getOnboardingItems, initState, etc. remain unchanged)

  final _pageController = PageController();

  int _currentPage = 0;

  List<OnboardingItem> _getOnboardingItems(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return [
      OnboardingItem(
        lightImagePath: 'assets/svgs/onboarding_library_light.svg',
        darkImagePath: 'assets/svgs/onboarding_library_dark.svg',
        title: localizations.onboardingSlide1Title,
        description: localizations.onboardingSlide1Description,
      ),
      OnboardingItem(
        lightImagePath: 'assets/svgs/onboarding_progress_light.svg',
        darkImagePath: 'assets/svgs/onboarding_progress_dark.svg',
        title: localizations.onboardingSlide2Title,
        description: localizations.onboardingSlide2Description,
      ),
      OnboardingItem(
        lightImagePath: 'assets/svgs/onboarding_community_light.svg',
        darkImagePath: 'assets/svgs/onboarding_community_dark.svg',
        title: localizations.onboardingSlide3Title,
        description: localizations.onboardingSlide3Description,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_pageController.hasClients && _pageController.page != null) {
        if (_pageController.page!.round() != _currentPage) {
          setState(() {
            _currentPage = _pageController.page!.round();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  Future<void> _onDone() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isFirstTime', false);

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final localizations = AppLocalizations.of(context)!;

    final onboardingItems = _getOnboardingItems(context);

    final isLastPage = _currentPage == onboardingItems.length - 1;

    final systemUiOverlayStyle = theme.brightness == Brightness.light
        ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent)
        : SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent);

    Color bottomContainerColor;

    if (theme.brightness == Brightness.dark) {
      bottomContainerColor = AppColors.darkBg;
    } else {
      bottomContainerColor = Colors.white;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                itemBuilder: (context, index) {
                  return _OnboardingSlide(
                      item: onboardingItems[index], index: index);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              color: bottomContainerColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardingItems.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.dividerColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    //  ****** تم إرجاع الأنيميشن مع الإصلاح ******

                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),

                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },

                      // **** هذا هو السطر الجديد والمهم الذي يمنع تغير الحجم ****

                      layoutBuilder: (Widget? currentChild,
                          List<Widget> previousChildren) {
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },

                      // --------------------------------------------------------

                      child: isLastPage
                          ? ElevatedButton(
                              key: const ValueKey('onboarding_done_button'),
                              onPressed: _onDone,
                              child: Text(localizations.onboardingButton),
                            )
                          : ElevatedButton(
                              key: const ValueKey('onboarding_next_button'),
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text(localizations.nextButton),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _OnboardingSlide class remains unchanged

class _OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;

  final int index;

  const _OnboardingSlide({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDarkMode = theme.brightness == Brightness.dark;

    final lightGradient = const LinearGradient(
        colors: [Color(0xFFEBF8FF), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);

    final darkGradient = LinearGradient(colors: [
      const Color(0xFF1E3A8A).withValues(alpha: 0.3),
      AppColors.darkBg
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

    final activeGradient = isDarkMode ? darkGradient : lightGradient;

    final imagePath = isDarkMode ? item.darkImagePath : item.lightImagePath;

    return Container(
      decoration: BoxDecoration(gradient: activeGradient),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          SvgPicture.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const Spacer(flex: 1),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.6,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
