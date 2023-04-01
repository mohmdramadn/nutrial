import 'package:flutter/material.dart';
import 'package:nutrial/constants/colors.dart';
import 'package:nutrial/screens/calculator/categories_screen.dart';
import 'package:nutrial/screens/calories/calories_screen.dart';
import 'package:nutrial/screens/pdf/pdf_screen.dart';
import 'package:nutrial/screens/profile/profile_screen.dart';
import 'package:nutrial/screens/settings/settings_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeViewModel extends ChangeNotifier {
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> buildScreens() {
    return [
      const ProfileScreen(),
      const CategoriesScreen(),
      const CaloriesScreen(),
      const PdfScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/profile.png', color: Colors.white),
        activeColorPrimary: AppColors.navBarBackground,
        inactiveColorPrimary: AppColors.navBarBackground,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/calculate.png', color: Colors.white),
        activeColorPrimary: AppColors.navBarBackground,
        inactiveColorPrimary: AppColors.navBarBackground,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/home.png', color: Colors.white),
        activeColorPrimary: AppColors.primaryLightColor3,
        inactiveColorPrimary: AppColors.primaryLightColor3,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/pdf.png', color: Colors.white),
        activeColorPrimary: AppColors.navBarBackground,
        inactiveColorPrimary: AppColors.navBarBackground,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/settings.png', color: Colors.white),
        activeColorPrimary: AppColors.navBarBackground,
        inactiveColorPrimary: AppColors.navBarBackground,
      ),
    ];
  }
}
