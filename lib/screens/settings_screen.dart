import 'package:flutter/material.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/screens/about_screen.dart';
import 'package:notehax/services/backup_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Backup Section
          _buildSectionHeader('Backup & Restore'),
          _buildSettingTile(
            icon: Icons.backup,
            title: 'Backup Notes',
            subtitle: 'Export all notes',
            onTap: _backupNotes,
          ),
          _buildSettingTile(
            icon: Icons.restore,
            title: 'Restore Notes',
            subtitle: 'Import from backup',
            onTap: () {
              // TODO: Implement file picker to select and restore backup
              // This will use file_picker package to select JSON backup file
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Restore feature coming soon!'),
                ),
              );
            },
          ),

          // Appearance Section
          _buildSectionHeader('Appearance'),
          _buildSettingTile(
            icon: Icons.palette,
            title: 'Theme',
            subtitle: 'Dark (Hacker Mode)',
            onTap: () {},
          ),

          // About Section
          _buildSectionHeader('About'),
          _buildSettingTile(
            icon: Icons.info_outline,
            title: 'About NoteHax',
            subtitle: 'Version ${AppConstants.version}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTextStyles.heading3.copyWith(
          color: AppColors.neonBlue,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.neonBlue),
      title: Text(title, style: AppTextStyles.body),
      subtitle: Text(subtitle, style: AppTextStyles.caption),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Future<void> _backupNotes() async {
    try {
      await BackupService.instance.shareBackup();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Backup created successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Backup failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
