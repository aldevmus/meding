import 'dart:async';

import 'package:app_links/app_links.dart';

import 'package:flutter/material.dart';

class DeepLinkService {

  // مكتبة AppLinks للاستماع للروابط

  final AppLinks _appLinks;

  // متغير لتخزين اشتراك الاستماع، لنتمكن من إلغائه لاحقًا

  StreamSubscription<Uri>? _linkSubscription;

  // --- [الإضافة الجديدة] ---

  // مفتاح الملاحة العام الذي سنستقبله من main.dart

  // للتحكم في التنقل من خارج شجرة الويدجتس

  final GlobalKey<NavigatorState> navigatorKey;

  // --- [التعديل الجديد] ---

  // الـ Constructor الآن يطلب تمرير مفتاح الملاحة

  DeepLinkService({required this.navigatorKey}) : _appLinks = AppLinks();

  /// تقوم هذه الدالة ببدء الاستماع للروابط العميقة.

  /// يجب استدعاؤها عند بدء تشغيل التطبيق.

  Future<void> initDeepLinks() async {

    // أولاً، نتحقق مما إذا كان التطبيق قد تم فتحه من خلال رابط وهو مغلق

    final initialUri = await _appLinks.getInitialAppLink();

    if (initialUri != null) {

      // إذا وجد رابط، نطبعه ونقوم بمعالجته

      debugPrint('App opened from link: $initialUri');

      _handleLink(initialUri);

    }

    // ثانيًا، نبدأ بالاستماع لأي روابط جديدة تصل بينما التطبيق يعمل في الواجهة

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {

      debugPrint('Link received while app is open: $uri');

      _handleLink(uri);

    });

  }

  /// تقوم هذه الدالة بتحليل الرابط وتحديد الإجراء المطلوب.

  void _handleLink(Uri uri) {

    debugPrint('--- Handling Link ---');

    debugPrint('Path: ${uri.path}');

    debugPrint('Query Parameters: ${uri.queryParameters}');

    debugPrint('---------------------');

    // لاحقًا، سنضيف هنا منطق التوجيه الفعلي

    // مثال على كيفية استخدام المفتاح العام للتوجيه:

    /*

    if (uri.path.contains('/password-reset')) {

      navigatorKey.currentState?.push(

        MaterialPageRoute(

          builder: (context) => PasswordResetScreen(token: uri.queryParameters['token']),

        ),

      );

    }

    */

  }

  /// تقوم هذه الدالة بإلغاء الاشتراك في استماع الروابط لمنع تسرب الذاكرة.

  /// يجب استدعاؤها عند إغلاق التطبيق.

  void dispose() {

    _linkSubscription?.cancel();

  }

}



