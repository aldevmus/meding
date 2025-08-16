import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:meding_app/features/home/presentation/widgets/home_app_bar.dart';

import 'package:meding_app/features/home/presentation/widgets/home_bottom_nav.dart';

import 'package:meding_app/features/home/presentation/widgets/banner_slider.dart';

import 'package:meding_app/features/home/presentation/widgets/quick_nav_grid.dart';

import 'package:meding_app/features/home/presentation/widgets/home_section.dart';

import 'package:meding_app/features/home/presentation/widgets/trending_file_list_item.dart';

import 'package:meding_app/features/home/presentation/widgets/suggested_lesson_card.dart';

import 'package:meding_app/features/home/presentation/widgets/suggested_courses_section.dart';

import 'package:meding_app/features/home/presentation/widgets/action_card.dart';

import 'package:meding_app/features/home/presentation/widgets/exclusive_content_card.dart';

import 'package:meding_app/features/home/presentation/widgets/article_list_item.dart';

import 'package:meding_app/features/home/presentation/widgets/lessons_for_you.dart';

import 'package:meding_app/features/home/presentation/widgets/new_courses.dart';

import 'package:meding_app/features/profile/presentation/screens/profile_screen.dart';

enum NavPage { home, community, forum, profile }

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override

  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  NavPage _currentPage = NavPage.home;

  void _onNavTapped(NavPage page) {

    if (page == _currentPage) return;

    setState(() {

      _currentPage = page;

    });

  }

  @override

  Widget build(BuildContext context) {

    Widget bodyContent;

    switch (_currentPage) {

      case NavPage.home:

        bodyContent = const _HomeView();

        break;
            
      case NavPage.profile:

        bodyContent = const ProfileScreen();

        break;
            
      default:

        bodyContent = Center(child: Text("Page: ${_currentPage.name}"));

        break;

    }

    

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final systemUiOverlayStyle = isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(

      value: systemUiOverlayStyle,

      child: Scaffold(

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        extendBodyBehindAppBar: true,

        extendBody: true,

        body: bodyContent,

        bottomNavigationBar: HomeBottomNav(

          currentPage: _currentPage,

          onPageSelected: _onNavTapped,

          onAddTapped: () { /* TODO: Implement Add Menu */ },

        ),

      ),

    );

  }

}

class _HomeView extends StatelessWidget {

  const _HomeView();

  @override

  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context)!;

    final topPadding = MediaQuery.of(context).padding.top

         + 8;

    final bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    

    final showActivationCard = true; 

    final List<Widget> sections = [

      if(showActivationCard)
       
        ActionCard(

          title: localizations.action_activate_sub_title,

          subtitle: localizations.action_activate_sub_subtitle,

          buttonText: localizations.action_activate_now,

          icon: Icons.workspace_premium_outlined,

          onButtonPressed: () {},

        ),

      const BannerSlider(),

      const QuickNavGrid(),

      

      HomeSection(

        title: localizations.section_exclusive,

        height: 96,

        onViewAll: () {},

        children: const [

          ExclusiveContentCard(),

          ExclusiveContentCard(),

          ExclusiveContentCard(),

          ExclusiveContentCard(),

        ],

      ),

      HomeSection(

        title: localizations.section_trending,

        isList: true,

        onViewAll: (){},

        children: const [

          TrendingFileListItem(title: "عنوان الملف الأول"),

          TrendingFileListItem(title: "ملف مهم جداً"),

          TrendingFileListItem(title: "ملخصات علم التشريح"),

        ],

      ),

      HomeSection(

          title: "أحدث المقالات", // TODO: Add to l10n

          isList: true,

          onViewAll: () {},

          children: const [

            ArticleListItem(

              title: "دراسة حالة: تأثير التغذية على أمراض القلب",

              author: "فريق Meding", readTime: "5 دقائق",

              imageUrl: 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?q=80&w=1982',

            ),

             ArticleListItem(

              title: "آخر الاكتشافات في علم الأعصاب",

              author: "د. سارة", readTime: "8 دقائق",

              imageUrl: 'https://images.unsplash.com/photo-1579165466949-518dd7627104?q=80&w=2070',

            ),

              ArticleListItem(

              title: "دراسة حالة: تأثير التغذية على أمراض القلب",

              author: "فريق Meding", readTime: "5 دقائق",

              imageUrl: 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?q=80&w=1982',

            ),

          ],

        ),

      HomeSection(

        title: localizations.section_suggested_lessons,

        height: 180,

        onViewAll: (){},

        children: const [

          LessonCard(title: "عنوان الدرس", instructor: "اسم المدرس"),

          LessonCard(title: "درس الكيمياء", instructor: "أ. سارة خالد"),

          LessonCard(title: "مقدمة في الطب", instructor: "د. يوسف"),

        ],

      ),

        

        HomeSection(

        title: localizations.section_suggested_lessons,

        height: 180,

        onViewAll: (){},

        children: const [

          SuggestedLessonCard(title: "عنوان الدرس", instructor: "اسم المدرس"),

          SuggestedLessonCard(title: "درس الكيمياء", instructor: "أ. سارة خالد"),

          SuggestedLessonCard(title: "مقدمة في الطب", instructor: "د. يوسف"),

        ],

      ),

      const SuggestedCoursesSection(),

      const CoursesSection(),
       
        
    ];

    return Scaffold(
        
    appBar: const HomeAppBar(),
        
    body: ListView.separated(

      padding: EdgeInsets.fromLTRB(16, topPadding, 16, bottomPadding),

      itemCount: sections.length,

      separatorBuilder: (context, index) => const SizedBox(height: 20), // تقليل المسافة

      itemBuilder: (context, index) {

        return sections[index];

          },
    
        ),
   
    );

  }

}

