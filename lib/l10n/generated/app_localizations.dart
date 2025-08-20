import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Your Complete Medical Library'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Description.
  ///
  /// In en, this message translates to:
  /// **'Instant access to thousands of courses, summaries, and video lessons.'**
  String get onboardingSlide1Description;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Learning Path'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Description.
  ///
  /// In en, this message translates to:
  /// **'Track your progress, take custom quizzes, and achieve your goals efficiently.'**
  String get onboardingSlide2Description;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Your Supportive Medical Community'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Description.
  ///
  /// In en, this message translates to:
  /// **'Connect with colleagues, share your experiences, and learn from the best professors.'**
  String get onboardingSlide3Description;

  /// No description provided for @onboardingButton.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get onboardingButton;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue your journey.'**
  String get loginToContinue;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @createOneNow.
  ///
  /// In en, this message translates to:
  /// **'Create one now'**
  String get createOneNow;

  /// No description provided for @joinMeding.
  ///
  /// In en, this message translates to:
  /// **'Join Meding'**
  String get joinMeding;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'Choose your account type and complete the details.'**
  String get chooseAccountType;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @professorAdmin.
  ///
  /// In en, this message translates to:
  /// **'Professor / Admin'**
  String get professorAdmin;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student Registration Number'**
  String get studentId;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @chooseSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Choose Specialty'**
  String get chooseSpecialty;

  /// No description provided for @specialtyMedicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get specialtyMedicine;

  /// No description provided for @specialtyDentistry.
  ///
  /// In en, this message translates to:
  /// **'Dentistry'**
  String get specialtyDentistry;

  /// No description provided for @specialtyPharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get specialtyPharmacy;

  /// No description provided for @chooseYear.
  ///
  /// In en, this message translates to:
  /// **'Choose Academic Year'**
  String get chooseYear;

  /// No description provided for @year1.
  ///
  /// In en, this message translates to:
  /// **'First Year'**
  String get year1;

  /// No description provided for @year2.
  ///
  /// In en, this message translates to:
  /// **'Second Year'**
  String get year2;

  /// No description provided for @year3.
  ///
  /// In en, this message translates to:
  /// **'Third Year'**
  String get year3;

  /// No description provided for @year4.
  ///
  /// In en, this message translates to:
  /// **'Fourth Year'**
  String get year4;

  /// No description provided for @year5.
  ///
  /// In en, this message translates to:
  /// **'Fifth Year'**
  String get year5;

  /// No description provided for @year6.
  ///
  /// In en, this message translates to:
  /// **'Sixth Year'**
  String get year6;

  /// No description provided for @year7.
  ///
  /// In en, this message translates to:
  /// **'Seventh Year'**
  String get year7;

  /// No description provided for @createStudentAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Student Account'**
  String get createStudentAccount;

  /// No description provided for @specialRegistration.
  ///
  /// In en, this message translates to:
  /// **'Special Registration'**
  String get specialRegistration;

  /// No description provided for @specialRegistrationInfo.
  ///
  /// In en, this message translates to:
  /// **'To register a professor or admin account, please contact the application administration directly to obtain login credentials.'**
  String get specialRegistrationInfo;

  /// No description provided for @contactAdmin.
  ///
  /// In en, this message translates to:
  /// **'Contact Administration'**
  String get contactAdmin;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginNow;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iAgreeTo;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @validatorRequiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get validatorRequiredField;

  /// No description provided for @validatorFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name.'**
  String get validatorFullNameHint;

  /// No description provided for @validatorFullNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please use English letters only.'**
  String get validatorFullNameInvalid;

  /// No description provided for @validatorStudentIdHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your student ID.'**
  String get validatorStudentIdHint;

  /// No description provided for @validatorStudentIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter numbers only.'**
  String get validatorStudentIdInvalid;

  /// No description provided for @validatorPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password.'**
  String get validatorPasswordHint;

  /// No description provided for @validatorPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long.'**
  String get validatorPasswordLength;

  /// No description provided for @passwordStrength.
  ///
  /// In en, this message translates to:
  /// **'Password Strength'**
  String get passwordStrength;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

  /// No description provided for @firebaseErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get firebaseErrorWeakPassword;

  /// No description provided for @firebaseErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use.'**
  String get firebaseErrorEmailInUse;

  /// No description provided for @firebaseErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get firebaseErrorGeneric;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get validatorEmailInvalid;

  /// No description provided for @validatorDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select your date of birth.'**
  String get validatorDateRequired;

  /// No description provided for @validatorSpecialtyRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the specialty.'**
  String get validatorSpecialtyRequired;

  /// No description provided for @validatorYearRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the academic year.'**
  String get validatorYearRequired;

  /// No description provided for @validatorAgeRequirement.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 17 years old.'**
  String get validatorAgeRequirement;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully! Please verify your email.'**
  String get accountCreatedSuccessfully;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @validatorGenderRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a gender.'**
  String get validatorGenderRequired;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful.'**
  String get loginSuccess;

  /// No description provided for @loginErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get loginErrorInvalid;

  /// No description provided for @resetPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get resetPasswordLink;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email.'**
  String get passwordResetEmailSent;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account is registered with this email.'**
  String get userNotFound;

  /// No description provided for @validatorPasswordLengthBetween.
  ///
  /// In en, this message translates to:
  /// **'Password must be between 8 and 20 characters.'**
  String get validatorPasswordLengthBetween;

  /// No description provided for @validatorPasswordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one uppercase letter.'**
  String get validatorPasswordUppercase;

  /// No description provided for @validatorPasswordNumber.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one number.'**
  String get validatorPasswordNumber;

  /// No description provided for @validatorFullNameInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first and last name.'**
  String get validatorFullNameInvalidFormat;

  /// No description provided for @validatorPasswordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter.'**
  String get validatorPasswordLowercase;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get nav_community;

  /// No description provided for @nav_forum.
  ///
  /// In en, this message translates to:
  /// **'Forum'**
  String get nav_forum;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;

  /// No description provided for @search_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Hello! What do you want to study today?'**
  String get search_placeholder;

  /// No description provided for @cancel_button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_button;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @section_exclusive.
  ///
  /// In en, this message translates to:
  /// **'Exclusive !'**
  String get section_exclusive;

  /// No description provided for @section_trending.
  ///
  /// In en, this message translates to:
  /// **'Trending Files !'**
  String get section_trending;

  /// No description provided for @section_suggested_lessons.
  ///
  /// In en, this message translates to:
  /// **'Suggested Lessons!'**
  String get section_suggested_lessons;

  /// No description provided for @section_suggested_courses.
  ///
  /// In en, this message translates to:
  /// **'Suggested Courses!'**
  String get section_suggested_courses;

  /// No description provided for @action_activate_sub_title.
  ///
  /// In en, this message translates to:
  /// **'Activate Subscription'**
  String get action_activate_sub_title;

  /// No description provided for @action_activate_sub_subtitle.
  ///
  /// In en, this message translates to:
  /// **'For full access to app features, please activate your subscription.'**
  String get action_activate_sub_subtitle;

  /// No description provided for @action_activate_now.
  ///
  /// In en, this message translates to:
  /// **'Activate Now'**
  String get action_activate_now;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @medicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicine;

  /// No description provided for @pharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacy;

  /// No description provided for @dentistry.
  ///
  /// In en, this message translates to:
  /// **'Dentistry'**
  String get dentistry;

  /// No description provided for @nursing.
  ///
  /// In en, this message translates to:
  /// **'Nursing'**
  String get nursing;

  /// No description provided for @discussion.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussion;

  /// No description provided for @ask.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get ask;

  /// No description provided for @postAuthorTeacher.
  ///
  /// In en, this message translates to:
  /// **'Professor'**
  String get postAuthorTeacher;

  /// No description provided for @postAuthorStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get postAuthorStudent;

  /// No description provided for @postTagPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get postTagPremium;

  /// No description provided for @postLikes.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get postLikes;

  /// No description provided for @postComments.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get postComments;

  /// No description provided for @postTimestampNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get postTimestampNow;

  /// No description provided for @postTimestampMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'Minutes ago'**
  String get postTimestampMinutesAgo;

  /// No description provided for @postTimestampHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'Hours ago'**
  String get postTimestampHoursAgo;

  /// No description provided for @postTimestampDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Days ago'**
  String get postTimestampDaysAgo;

  /// No description provided for @viewPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get viewPostTitle;

  /// No description provided for @commentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commentsTitle;

  /// No description provided for @addCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get addCommentHint;

  /// No description provided for @createPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPostTitle;

  /// No description provided for @postFormFieldTitl.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get postFormFieldTitl;

  /// No description provided for @postFormFieldTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Write a clear title for your post...'**
  String get postFormFieldTitleHint;

  /// No description provided for @postFormFieldContent.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get postFormFieldContent;

  /// No description provided for @postFormFieldContentHint.
  ///
  /// In en, this message translates to:
  /// **'Write the details of your post here...'**
  String get postFormFieldContentHint;

  /// No description provided for @postFormFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get postFormFieldCategory;

  /// No description provided for @postFormFieldCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'E.g: Pathology, Surgery...'**
  String get postFormFieldCategoryHint;

  /// No description provided for @postFormAttachImage.
  ///
  /// In en, this message translates to:
  /// **'Attach Image (optional)'**
  String get postFormAttachImage;

  /// No description provided for @postFormDragOrBrowse.
  ///
  /// In en, this message translates to:
  /// **'Drag & drop an image here or browse'**
  String get postFormDragOrBrowse;

  /// No description provided for @postFormSaveAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get postFormSaveAsDraft;

  /// No description provided for @postFormPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get postFormPublish;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'One last step!'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We have sent an activation link to your email:'**
  String get verifyEmailBody;

  /// No description provided for @resendEmailButton.
  ///
  /// In en, this message translates to:
  /// **'Resend Link'**
  String get resendEmailButton;

  /// No description provided for @resendEmailCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend in {countdown}s'**
  String resendEmailCountdown(Object countdown);

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @emailVerificationSent.
  ///
  /// In en, this message translates to:
  /// **'Verification link sent to your email'**
  String get emailVerificationSent;

  /// No description provided for @emailVerificationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while sending the email'**
  String get emailVerificationError;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Successfully Verified!'**
  String get successTitle;

  /// No description provided for @successBody.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Meding. You are now ready to start your educational journey and explore the world of medicine.'**
  String get successBody;

  /// No description provided for @ctaStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Start Learning Now'**
  String get ctaStartLearning;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
