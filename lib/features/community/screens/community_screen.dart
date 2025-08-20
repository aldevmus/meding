import 'package:flutter/material.dart';
// Important: Make sure your file paths are correct for your project structure
import '../models/post_model.dart';
import '../widgets/post_card.dart';
import '../widgets/glassmorphism_app_bar.dart';
import '../widgets/community_filter_chips.dart';
import '../widgets/floating_background.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        authorName: "د. فاطمة محمود",
        authorAvatarUrl: "https://placehold.co/40x40/f56565/FFFFFF?text=F",
        authorRole: "أستاذ",
        isVerified: true,
        isPremium: true,
        title: "مشاركة حالة سريرية مثيرة للاهتمام",
        content:
            "زملاء، أشارك معكم اليوم صورة أشعة لحالة نادرة واجهتها في قسم الطوارئ. ما هو تشخيصكم المبدئي؟",
        imageUrl: 'https://placehold.co/600x300/3182CE/FFFFFF?text=X-Ray+Image',
        likes: 112,
        comments: 23,
        timestamp: "منذ ساعتين",
      ),
      Post(
        authorName: "أحمد بن علي",
        authorAvatarUrl: "https://placehold.co/40x40/2B6CB0/FFFFFF?text=A",
        authorRole: "طالب",
        title: "سؤال حول أفضل مرجع في علم الأمراض (Pathology)؟",
        content:
            "مرحباً جميعاً، أبحث عن توصياتكم لأفضل كتاب أو مرجع شامل في علم الأمراض للمرحلة الجامعية...",
        imageUrl: null, // No image for this post
        likes: 15,
        comments: 4,
        timestamp: "منذ 5 دقائق",
      ),
      Post(
        authorName: "سارة مراد",
        authorAvatarUrl: "https://placehold.co/40x40/38A169/FFFFFF?text=S",
        authorRole: "طالب",
        title: "نقاش: كيف تنظمون وقتكم بين الدراسة والتدريب؟",
        content:
            "أجد صعوبة في الموازنة بين متطلبات الدراسة وحضور التدريبات في المستشفى. هل لديكم أي نصائح أو استراتيجيات فعالة لإدارة الوقت؟",
        imageUrl: null, // No image
        likes: 88,
        comments: 19,
        timestamp: "منذ 5 ساعات",
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassmorphismAppBar(),
      body: Stack(
        children: [
          const FloatingBackground(),
          ListView(
            padding: EdgeInsets.only(
              top: 68 + MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            children: [
              const CommunityFilterChips(),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return PostCard(post: posts[index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
