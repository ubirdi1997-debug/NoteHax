import 'package:flutter/material.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.neonBlue,
                    AppColors.neonGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonBlue.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.note_alt_rounded,
                size: 60,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // App Name
            Text(
              AppConstants.appName,
              style: AppTextStyles.heading1.copyWith(
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      AppColors.neonBlue,
                      AppColors.neonGreen,
                    ],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Tagline
            Text(
              AppConstants.tagline,
              style: AppTextStyles.bodySecondary.copyWith(
                color: AppColors.neonBlue,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Version
            const Text(
              'Version ${AppConstants.version}',
              style: AppTextStyles.caption,
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Company Info Card
            _buildInfoCard(
              icon: Icons.business,
              title: 'Developed by',
              content: AppConstants.company,
            ),

            const SizedBox(height: AppSpacing.md),

            // Contact Card
            _buildInfoCard(
              icon: Icons.email,
              title: 'Contact Email',
              content: AppConstants.supportEmail,
              onTap: () => _sendEmail(AppConstants.supportEmail),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Features List
            Text(
              'Features',
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.neonBlue,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            _buildFeatureItem('🧠 Smart Notes Engine'),
            _buildFeatureItem('⚡ Quick Hax Panel'),
            _buildFeatureItem('🔐 Secure Vault Notes'),
            _buildFeatureItem('⏳ Time Capsule Notes'),
            _buildFeatureItem('🎨 Note Personalization'),
            _buildFeatureItem('📌 Smart Reminders'),
            _buildFeatureItem('🔍 Instant Search'),
            _buildFeatureItem('☁️ Backup System'),

            const SizedBox(height: AppSpacing.xxl),

            // Copyright
            const Text(
              '© 2024 ${AppConstants.company}',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.sm),

            const Text(
              'All rights reserved',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.neonBlue.withOpacity(0.2),
                borderRadius: AppBorderRadius.small,
              ),
              child: Icon(icon, color: AppColors.neonBlue),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          Text(
            feature,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=NoteHax Support',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}
