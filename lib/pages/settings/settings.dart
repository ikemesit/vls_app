import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true, elevation: 0),
      body: ListView(
        children: [
          // Account Section
          _buildSectionHeader('Account'),
          _buildSettingsTile(
            context,
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'View and edit your profile',
            onTap: () {
              // Navigate to profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.email,
            title: 'Change Email',
            subtitle: 'Update your email address',
            onTap: () {
              // Navigate to change email page
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Change Email tapped')));
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              // Navigate to change password page
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Change Password tapped')));
            },
          ),

          // Preferences Section
          _buildSectionHeader('Preferences'),
          _buildSwitchTile(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Enable or disable push notifications',
            initialValue: true,
            onChanged: (value) {
              // Handle notification toggle
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications set to $value')),
              );
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.palette,
            title: 'Theme',
            subtitle: 'Switch between light and dark mode',
            trailing: DropdownButton<String>(
              value: 'Light',
              items:
                  ['Light', 'Dark', 'System']
                      .map(
                        (mode) =>
                            DropdownMenuItem(value: mode, child: Text(mode)),
                      )
                      .toList(),
              onChanged: (value) {
                // Handle theme change
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Theme set to $value')));
              },
            ),
            onTap: null, // Disable tap since dropdown handles interaction
          ),

          // General Section
          _buildSectionHeader('General'),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Select app language',
            onTap: () {
              // Navigate to language selection page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Language selection tapped')),
              );
            },
          ),
          _buildSettingsTile(
            context,
            icon: Icons.info,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () {
              // Navigate to about page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutPage()),
              );
            },
          ),

          // Logout Section
          _buildSectionHeader(''),
          _buildSettingsTile(
            context,
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Color? textColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.grey[700]),
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black)),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: TextStyle(color: Colors.grey[600]))
              : null,
      trailing: trailing ?? (onTap != null ? Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required bool initialValue,
    required ValueChanged<bool> onChanged,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool value = initialValue;
        return ListTile(
          leading: Icon(icon, color: Colors.grey[700]),
          title: Text(title),
          subtitle:
              subtitle != null
                  ? Text(subtitle, style: TextStyle(color: Colors.grey[600]))
                  : null,
          trailing: Switch(
            value: value,
            onChanged: (newValue) {
              setState(() => value = newValue);
              onChanged(newValue);
            },
          ),
          onTap: () {
            setState(() => value = !value);
            onChanged(value);
          },
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle logout logic here
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Logged out')));
                  Navigator.pop(context);
                  // Navigate to login page or similar
                },
                child: Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}

// Placeholder Profile Page
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Page')),
    );
  }
}

// Placeholder About Page
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('App Version: 1.0.0'),
            Text('Volkspartij Leefbaar Suriname'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Settings App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingsPage(),
    ),
  );
}
