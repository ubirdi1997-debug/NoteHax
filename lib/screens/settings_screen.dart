import 'package:flutter/material.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/screens/about_screen.dart';
import 'package:notehax/services/backup_service.dart';
import 'package:notehax/services/biometric_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricsEnabled = false;
  bool _hasPin = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final biometricsEnabled =
        await BiometricService.instance.isBiometricsEnabled();
    final hasPin = await BiometricService.instance.hasPin();

    setState(() {
      _biometricsEnabled = biometricsEnabled;
      _hasPin = hasPin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Security Section
          _buildSectionHeader('Security'),
          _buildSettingTile(
            icon: Icons.fingerprint,
            title: 'Biometric Lock',
            subtitle: 'Use fingerprint or face ID',
            trailing: Switch(
              value: _biometricsEnabled,
              onChanged: (value) async {
                await BiometricService.instance.setBiometricsEnabled(value);
                setState(() => _biometricsEnabled = value);
              },
            ),
          ),
          _buildSettingTile(
            icon: Icons.pin,
            title: 'PIN Lock',
            subtitle: _hasPin ? 'Change PIN' : 'Set up PIN',
            onTap: () {
              // TODO: Implement PIN setup
            },
          ),

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
              // TODO: Implement restore
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
