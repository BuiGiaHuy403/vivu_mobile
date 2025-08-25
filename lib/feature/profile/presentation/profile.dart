import 'package:flutter/material.dart';

import '../../../core/common/constants/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: MAIN_LINEAR,
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Hồ sơ của tôi',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/default_avatar.png'),
                  // TODO: Replace with network image when API is integrated
                ),
                const SizedBox(height: 16),
                const Text(
                  'Vivuer',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _buildMenuSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        _ProfileMenuItem(
          icon: Icons.person_outline,
          title: 'Hồ sơ',
          onTap: () {/* Navigate to profile details */},
        ),
        _ProfileMenuItem(
          icon: Icons.sync,
          title: 'Cập nhật dữ liệu',
          onTap: () {/* Handle data sync */},
        ),
        _ProfileMenuItem(
          icon: Icons.lock_outline,
          title: 'Đổi mật khẩu',
          onTap: () {/* Navigate to change password */},
        ),
        _ProfileMenuItem(
          icon: Icons.settings_outlined,
          title: 'Cài đặt',
          onTap: () {/* Navigate to settings */},
        ),
        _ProfileMenuItem(
          icon: Icons.logout,
          title: 'Đăng xuất',
          onTap: () {/* Handle logout */},
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
