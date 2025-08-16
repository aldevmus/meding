// lib/features/profile/presentation/widgets/profile_content_tabs.dart

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart'; // Make sure you have AppColors

class ProfileContentTabs extends StatefulWidget {

  // In a real app, you would pass the userId to fetch content for each tab

  // final String userId;

  const ProfileContentTabs({super.key});

  @override

  State<ProfileContentTabs> createState() => _ProfileContentTabsState();

}

class _ProfileContentTabsState extends State<ProfileContentTabs> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override

  void initState() {

    super.initState();

    _tabController = TabController(length: 4, vsync: this);

  }

  @override

  void dispose() {

    _tabController.dispose();

    super.dispose();

  }

  @override

  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final activeTabColor = isDarkMode ? AppColors.primaryBlueAccent : AppColors.primaryBlue;

    final inactiveTabColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600;

    return Column(

      children: [

        // This is the Tab Bar itself

        Container(

          decoration: BoxDecoration(

            border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1.0)),

          ),

          child: TabBar(

            controller: _tabController,

            isScrollable: false,

            indicatorColor: activeTabColor,

            indicatorWeight: 3.0,

            labelColor: activeTabColor,

            unselectedLabelColor: inactiveTabColor,

            labelStyle: const TextStyle(

              fontWeight: FontWeight.bold,

              fontFamily: 'Cairo',

              fontSize: 16

            ),

            unselectedLabelStyle: const TextStyle(

              fontWeight: FontWeight.w600,

              fontFamily: 'Cairo',

              fontSize: 16

            ),

            tabs: const [

              Tab(text: "Files"),

              Tab(text: "Courses"),

              Tab(text: "Lessons"),

              Tab(text: "Articles"),

            ],

          ),

        ),

        

        // This is the content that appears when a tab is selected

        SizedBox(

          // Give the content area a fixed height for now

          // In a real app, this would be more dynamic

          height: 300, 

          child: TabBarView(

            controller: _tabController,

            children: [

              // We will build the real content later. These are just placeholders.

              Center(child: Text("Files Content Goes Here")),

              Center(child: Text("Courses Content Goes Here")),

              Center(child: Text("Lessons Content Goes Here")),

              Center(child: Text("Articles Content Goes Here")),

            ],

          ),

        ),

      ],

    );

  }

}

