import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/storage_service.dart';

class CelebrationScreen extends StatelessWidget {
  final int freedBytes;

  const CelebrationScreen({super.key, required this.freedBytes});

  @override
  Widget build(BuildContext context) {
    final formattedSize = StorageService.formatBytes(freedBytes);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Trophy / Check Circle Icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.keepEmerald.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.keepEmerald,
                  size: 56,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.celebrationTitle,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                formattedSize,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.keepEmerald,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Moved to Recently Deleted album.',
                style: const TextStyle(
                  color: AppColors.textDarkSecondary,
                  fontSize: 14,
                ),
              ),
              const Spacer(),

              // Share Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Share.share(
                      'I just freed $formattedSize of junk storage using Gigaless! 🚀',
                      subject: 'Gigaless Storage Cleanup',
                    );
                  },
                  icon: const Icon(Icons.share, color: AppColors.primaryBlue),
                  label: Text(
                    AppStrings.shareAchievement,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Done Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.done,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
