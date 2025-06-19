import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/routes/route_names.dart';
import 'package:uas_kel7/services/auth_service.dart';
import 'package:uas_kel7/views/crud_screen.dart';
import 'package:uas_kel7/views/explore_screen.dart';
import 'package:uas_kel7/views/favorite_screen.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'package:uas_kel7/views/login_screen.dart';
import 'package:uas_kel7/views/splash_screen.dart';
import 'package:uas_kel7/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  // Placeholder data pengguna
  final String userName = "Nama User";
  final String userEmail = "user1234@gmail.com";

  void _onBottomNavTapped(int index) {
    if (_currentIndex == index && index == 3) return;
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExploreScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesScreen()),
        );
        break;
      case 3:
        // Sudah di halaman Profile
        break;
    }
  }

  void _handleEditProfile() {
    print('Edit Profile tapped');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Edit Profile tapped (Placeholder)')),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CrudScreen()),
    );
    // Navigasi ke halaman edit profil
    // context.goNamed(RouteNames.editProfile);
  }

  void _handleEditPassword() {
    print('Edit Password tapped');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Password tapped (Placeholder)')),
    );
    // Navigasi ke halaman edit password
    // context.goNamed(RouteNames.editPassword);
  }

  void _handleHistory() {
    print('History tapped');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('History tapped (Placeholder)')),
    );
    // Navigasi ke halaman history
    // context.goNamed(RouteNames.history);
  }

  void _handleLogOut() async {
    // Panggil metode logout dari AuthService
    await Provider.of<AuthService>(context, listen: false).logout();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  Widget _buildProfileOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey[200]!, width: 0.5),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 47, 12, 243),
          size: 22.sp,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Colors.grey[600],
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 47, 12, 243),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // User Info Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 12, 243),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        47,
                        12,
                        243,
                      ).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Icon(
                        Icons.person_outline,
                        size: 35.sp,
                        color: const Color.fromARGB(255, 47, 12, 243),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.fullName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildProfileOptionItem(
                    icon: Icons.edit_outlined,
                    title: 'Berita Saya',
                    onTap: _handleEditProfile,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildProfileOptionItem(
                icon: Icons.logout_outlined,
                title: 'Log out',
                onTap: _handleLogOut,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 47, 12, 243),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
