import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class BottomNavShell extends StatelessWidget {
  const BottomNavShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onDestinationSelected,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.secondary.withValues(alpha: 0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 64,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.explore, color: AppColors.primary),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.search, color: AppColors.primary),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.sync_alt_outlined, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.sync_alt, color: AppColors.primary),
              label: 'Activity',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppColors.textMuted),
              selectedIcon: Icon(Icons.person, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
