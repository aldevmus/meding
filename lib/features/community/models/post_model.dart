class Post {
  final String authorName;
  final String authorAvatarUrl;
  final String authorRole;
  final bool isVerified;
  final bool isPremium;
  final String title;
  final String content;
  final String? imageUrl; // Nullable for posts without images
  final int likes;
  final int comments;
  final String timestamp;

  Post({
    required this.authorName,
    required this.authorAvatarUrl,
    required this.authorRole,
    this.isVerified = false,
    this.isPremium = false,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.timestamp,
  });
}
