class UserProfile {

  final String id;

  final String name;

  final String userType; // 'publisher' or 'student'

  final bool isVerified;

  // ... add all other fields from your data

  UserProfile({

    required this.id,

    required this.name,

    required this.userType,

    this.isVerified = false,

  });

}

