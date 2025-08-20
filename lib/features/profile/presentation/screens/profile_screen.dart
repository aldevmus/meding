import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/features/profile/presentation/models/user_profile.dart';

import 'package:meding_app/features/profile/presentation/widgets/profile_app_bar.dart';

import 'package:meding_app/features/profile/presentation/widgets/profile_header.dart';

// ADD THIS AT THE TOP OF THE FILE
enum ProfileViewType { myPublisher, otherPublisher, myStudent }

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _profileData;

  late bool _isMyProfile;

  // ✅ ADD THIS NEW VARIABLE
  ProfileViewType _currentViewType = ProfileViewType.myPublisher;

  @override
  void initState() {
    super.initState();

    _isMyProfile = widget.userId == null;

    _loadProfileData();
  }

  // REPLACE THE OLD METHOD WITH THIS
  void _loadProfileData() {
    switch (_currentViewType) {
      case ProfileViewType.myPublisher:
        _profileData = UserProfile(id: 'my_id', name: 'Dr. Youssef Ben Ali', userType: 'publisher', isVerified: true);
        _isMyProfile = true;
        break;
      case ProfileViewType.otherPublisher:
        _profileData = UserProfile(id: 'publisher_id', name: 'Dr. Youssef Ben Ali', userType: 'publisher', isVerified: true);
        _isMyProfile = false;
        break;
      case ProfileViewType.myStudent:
        _profileData = UserProfile(id: 'my_student_id', name: 'Ahmed Khaled', userType: 'student');
        _isMyProfile = true;
        break;
    }
  }
  
  // ✅ ADD THIS NEW METHOD
  void _switchView(ProfileViewType newView) {
    setState(() {
      _currentViewType = newView;
      _loadProfileData();
    });
  }

  // ✅ AND ADD THIS NEW WIDGET-BUILDING METHOD
  Widget _buildDebugSwitcher() {
    return Container(
      color: Colors.yellow.shade100,
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.0,
        children: [
          ElevatedButton(onPressed: () => _switchView(ProfileViewType.myPublisher), child: const Text("My Profile (Pub)")),
          ElevatedButton(onPressed: () => _switchView(ProfileViewType.otherPublisher), child: const Text("Other's (Pub)")),
          ElevatedButton(onPressed: () => _switchView(ProfileViewType.myStudent), child: const Text("My Profile (Stu)")),
        ],
      ),
    );
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
            
             SliverToBoxAdapter(child: _buildDebugSwitcher()),
             
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
