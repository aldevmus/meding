import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final _dummyBanners = [
    {
      "color": AppColors.primaryBlue,
      "tag": "جديد: كورس",
      "title": "شامل للأعصاب !",
      "subtitle": "دورة مباشرة + PDF + فيديو",
      "button": "اكتشف الآن"
    },
    {
      "color": Colors.green.shade600,
      "tag": "عرض خاص",
      "title": "علم الأدوية للمبتدئين",
      "subtitle": "خصم 30% لفترة محدودة",
      "button": "سجل اهتمامك"
    },
    {
      "color": Colors.purple.shade600,
      "tag": "مكتبة متكاملة",
      "title": "ملفات التشريح الكاملة",
      "subtitle": "كل ما تحتاجه في مكان واحد",
      "button": "تصفح الملفات"
    },
    {
      "color": Colors.red.shade600,
      "tag": "قادمون",
      "title": "اختبارات تجريبية",
      "subtitle": "استعد لامتحاناتك القادمة",
      "button": "اعرف المزيد"
    },
    {
      "color": Colors.indigo.shade600,
      "tag": "مجتمع Meding",
      "title": "شارك معرفتك وخبرتك",
      "subtitle": "انضم إلى آلاف الطلاب",
      "button": "انضم الآن"
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int next = _pageController.page!.round();

      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    final titleFont = isArabic ? 'Cairo' : 'Inter';

    final titleSize = isArabic ? 30.0 : 26.0;

    return SizedBox(
      height: 208,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _dummyBanners.length,
            itemBuilder: (context, index) {
              final banner = _dummyBanners[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: banner["color"] as Color,
                child: Stack(
                  children: [
                    Positioned(
                        top: -40,
                        right: -40,
                        child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.1)))),
                    Positioned(
                        bottom: 20,
                        left: -20,
                        child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.1)))),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(banner["tag"] as String,
                              style: TextStyle(
                                  fontFamily: titleFont,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 72,
                            child: Text(
                              banner["title"] as String,
                              style: TextStyle(
                                  fontFamily: titleFont,
                                  color: Colors.white,
                                  fontSize: titleSize,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2),
                              maxLines: 2,
                            ),
                          ),
                          Text(banner["subtitle"] as String,
                              style: TextStyle(
                                  fontFamily: titleFont,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14)),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,

                              foregroundColor: Colors.black87,

                              shape: const StadiumBorder(),

                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8), // زر أصغر

                              textStyle: TextStyle(
                                  fontFamily: titleFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            child: Text(banner["button"] as String),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_dummyBanners.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 6,
                  width: _currentPage == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
