import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'profile_view.dart';
import 'settings_view.dart';

class MainView extends StatelessWidget {
  final RxInt selectedIndex = 0.obs; // Track the selected tab

  final List<Widget> pages = [HomeView(), ProfileView(), SettingsView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[selectedIndex.value]),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (index) => selectedIndex.value = index, // Update tab
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'News'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
