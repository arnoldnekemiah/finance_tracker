import 'package:flutter/material.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryGold, AppColors.darkBlue],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryGold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Finance Tracker',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.primaryGold),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic if needed
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart, color: AppColors.primaryGold),
            title: Text('Reports'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.primaryGold),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: AppColors.primaryGold),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: AppColors.primaryGold),
            title: Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation logic
            },
          ),
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.error),
            title: Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () {
              // Add logout logic
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
