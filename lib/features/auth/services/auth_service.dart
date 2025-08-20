import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة تسجيل طالب جديد (تبقى كما هي من قبل)

  Future<User?> registerStudent({
    required String email,
    required String password,
    required String fullName,
    required String studentId,
    required String dateOfBirth,
    required String? specialty,
    required String? year,
    required String? gender,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;

    if (user == null)
      throw Exception("Failed to create user in Firebase Auth.");

    final birthYear = DateTime.parse(dateOfBirth).year;

    final calculatedYear = birthYear + 4;

    final medingId = '$calculatedYear$studentId';

    const String maleAvatarUrl = "https://example.com/male_avatar.png";

    const String femaleAvatarUrl = "https://example.com/female_avatar.png";

    final String profilePictureUrl =
        (gender == 'male') ? maleAvatarUrl : femaleAvatarUrl;

    await _firestore.collection('users').doc(user.uid).set({
      'medingId': medingId,
      'email': user.email,
      'fullName': fullName,
      'createdAt': FieldValue.serverTimestamp(),
      'role': 'student',
      'gender': gender,
      'profilePictureUrl': profilePictureUrl,
      'points': 0,
      'level': 1,
      'studentInfo': {
        'studentId': studentId,
        'dateOfBirth': dateOfBirth,
        'specialty': specialty,
        'currentYear': year,
        'faculty': null,
        'studentCardUrl': null
      },
      'status': {
        'accountStatus': 'pending_payment',
        'isEmailVerified': false,
        'isAccountVerified': false,
        'isPremium': false
      },
      'subscription': {
        'type': 'none',
        'paymentStatus': 'pending',
        'startDate': null,
        'endDate': null
      },
    });

    await user.sendEmailVerification();

    return user;
  }

  // دالة تسجيل الدخول

  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  // دالة إرسال إيميل إعادة تعيين كلمة المرور

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
