import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/features/profile/presentation/models/user_profile.dart';

import 'package:meding_app/features/profile/presentation/widgets/profile_app_bar.dart';

import 'package:meding_app/features/profile/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _profileData;

  late bool _isMyProfile;

  @override
  void initState() {
    super.initState();

    _isMyProfile = widget.userId == null;

    _loadProfileData();
  }

  void _loadProfileData() {
    // To test the student view, change the 'userType' to 'student'

    if (_isMyProfile) {
      // My Profile

      _profileData = UserProfile(
          id: 'my_id',
          name: 'Dr. Youssef Ben Ali',
          userType: 'publisher',
          isVerified: true);
    } else {
      // Other User's Profile

      _profileData = UserProfile(
          id: 'some_other_id',
          name: 'Dr. Youssef Ben Ali',
          userType: 'publisher',
          isVerified: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // The TabController is needed for the tabs to work.

    // We set the length based on if the user is a publisher or not.

    return DefaultTabController(
      length: _profileData.userType == 'publisher'
          ? 4
          : 0, // 4 tabs for publisher, 0 for student

      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            // Sliver 1: The AppBar that is always visible at the top.

            ProfileSliverAppBar(user: _profileData, isMyProfile: _isMyProfile),

            // Sliver 2: The header content (avatar, stats) that scrolls up and disappears.

            SliverToBoxAdapter(
              child:
                  ProfileHeader(user: _profileData, isMyProfile: _isMyProfile),
            ),

            // Only show tabs for publishers

            if (_profileData.userType == 'publisher') ...[
              // Sliver 3: The TabBar that scrolls up and then sticks to the bottom of the AppBar.

              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  const TabBar(
                    labelColor: AppColors.primaryBlue,
                    indicatorColor: AppColors.primaryBlue,
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 3.0,
                    tabs: [
                      Tab(text: "Files"),
                      Tab(text: "Courses"),
                      Tab(text: "Lessons"),
                      Tab(text: "Articles"),
                    ],
                  ),
                ),

                pinned: true, // This is what makes it stick!
              ),

              // Sliver 4: The content of the tabs, which fills the rest of the screen.

              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    Center(child: Text("Files Content Grid")),
                    Center(child: Text("Courses Content List")),
                    Center(child: Text("Lessons Content List")),
                    Center(child: Text("Articles Content List")),
                  ],
                ),
              ),
            ],

            // If the user is a student, we add their content here

            if (_profileData.userType == 'student') ...[
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Saved Content",
                            style: Theme.of(context).textTheme.headlineSmall),

                        // ... (List of saved content would go here)
                      ],
                    )),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// Helper class to make the TabBar a sticky sliver header

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
