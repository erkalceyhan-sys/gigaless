import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/storage_service.dart';
import '../models/media_item.dart';
import '../services/photo_service.dart';
import '../controllers/swipe_deck_controller.dart';
import 'swipe_deck_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalSavedBytes = 0;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final saved = await StorageService.getTotalSavedBytes();
    final hasPerm = await PhotoService.hasPermission();
    if (mounted) {
      setState(() {
        _totalSavedBytes = saved;
        _hasPermission = hasPerm;
      });
    }
  }

  Future<void> _startCleanup(CleanupCategory category) async {
    if (!_hasPermission) {
      final granted = await PhotoService.requestPermission();
      if (!granted) return;
      setState(() => _hasPermission = true);
    }

    if (!mounted) return;
    final controller = context.read<SwipeDeckController>();
    controller.setLoading(true);

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => SwipeDeckScreen(category: category),
          ),
        )
        .then((_) => _loadInitialState());

    final items = await PhotoService.fetchCategoryItems(category: category);
    controller.setItems(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (lang) {
              setState(() {
                AppStrings.setLanguage(lang);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'de', child: Text('Deutsch')),
              const PopupMenuItem(value: 'es', child: Text('Español')),
              const PopupMenuItem(value: 'fr', child: Text('Français')),
              const PopupMenuItem(value: 'ja', child: Text('日本語')),
              const PopupMenuItem(value: 'tr', child: Text('Türkçe')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Storage Card
              _buildStorageHeroCard(),
              const SizedBox(height: 24),

              // Categories Header
              Text(
                AppStrings.categories,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14),

              // Category Cards Grid
              _buildCategoryCard(
                title: AppStrings.screenshots,
                subtitle: 'Fastest way to clear junk',
                icon: Icons.screenshot_outlined,
                accentColor: AppColors.primaryBlue,
                onTap: () => _startCleanup(CleanupCategory.screenshots),
              ),
              const SizedBox(height: 12),
              _buildCategoryCard(
                title: AppStrings.duplicates,
                subtitle: 'Find and keep the best shot',
                icon: Icons.copy_all_outlined,
                accentColor: AppColors.reviewAmber,
                onTap: () => _startCleanup(CleanupCategory.duplicates),
              ),
              const SizedBox(height: 12),
              _buildCategoryCard(
                title: AppStrings.largeVideos,
                subtitle: 'Videos over 50 MB',
                icon: Icons.video_library_outlined,
                accentColor: AppColors.trashCoral,
                onTap: () => _startCleanup(CleanupCategory.largeVideos),
              ),
              const SizedBox(height: 12),
              _buildCategoryCard(
                title: AppStrings.monthByMonth,
                subtitle: 'Declutter month by month',
                icon: Icons.calendar_month_outlined,
                accentColor: AppColors.keepEmerald,
                onTap: () => _startCleanup(CleanupCategory.monthly),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.storageSaved,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textDarkSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            StorageService.formatBytes(_totalSavedBytes),
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _startCleanup(CleanupCategory.quickClean),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                AppStrings.quickClean,
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
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textDarkSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textDarkSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
