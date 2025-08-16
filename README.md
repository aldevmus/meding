# Meding-app

## Getting Started


## لزيادة العرض قليلًا (التكيف)

التكيف التلقائي يأتي من AnimatedSize و mainAxisSize: MainAxisSize.min. لزيادة العرض قليلًا بشكل دائم، يمكنك ببساطة زيادة المسافة الأفقية (padding) داخل كل زر.

المكان: ملف home_bottom_nav.dart -> ويدجت _NavItem.
A few resources to get you started if this is your first Flutter project:

// ...

child: AnimatedContainer(

  // ...

  // ✅ قم بزيادة هذا الرقم لزيادة العرض

  padding: const EdgeInsets.symmetric(horizontal: 14), // <-- كان 12

  // ...

),

// ...

## لزيادة الطول قليلًا

يمكنك التحكم بالطول مباشرة من خاصية height.

المكان: ملف home_bottom_nav.dart -> ويدجت _NavItem.
// ...

child: AnimatedContainer(

  duration: const Duration(milliseconds: 400),

  // ✅ قم بزيادة هذا الرقم لزيادة الطول

  height: 56, // <-- كان 52

  curve: Curves.easeInOut,

  // ...

),

// ...

## لرفع الشريط للأعلى قليلًا

لرفع الشريط بالكامل بعيدًا عن حافة الشاشة السفلية، يمكنك التحكم في الهامش السفلي (bottom padding).

المكان: ملف home_bottom_nav.dart -> ويدجت HomeBottomNav (الويدجت الرئيسي).
// ...

return Row(

  mainAxisAlignment: MainAxisAlignment.center,

  children: [

    Padding(

      // ✅ قم بزيادة الرقم الأخير لرفع الشريط

      padding: const EdgeInsets.only(bottom: 28.0), // <-- كان 24.0

      child: ClipRRect(

        // ...

      ),

    ),

  ],

);

// ...


- https://flutter.dev/docs/get-started/codelab
- https://flutter.dev/docs/cookbook

For help getting started with Flutter, view our
https://flutter.dev/docs, which offers tutorials,
samples, guidance on mobile development, and a full API reference.

