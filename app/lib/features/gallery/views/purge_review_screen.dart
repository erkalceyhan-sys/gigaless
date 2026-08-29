import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/swipe_deck_controller.dart';
import '../../stats/views/celebration_screen.dart';

class PurgeReviewScreen extends StatelessWidget {
  const PurgeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.reviewTitle),
      ),
      body: Consumer<SwipeDeckController>(
        builder: (context, controller, child) {
          if (controller.toTrash.isEmpty) {
            return Center(
              child: Text(
                'No items marked for deletion',
                style: TextStyle(color: AppColors.textDarkSecondary),
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                // Summary Card
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.spaceToFree,
                            style: const TextStyle(
                              color: AppColors.textDarkSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.formattedTrashSize,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.trashCoral,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.trashCoral.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${controller.toTrash.length} items',
                          style: const TextStyle(
                            color: AppColors.trashCoral,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Grid of items to be deleted
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.toTrash.length,
                    itemBuilder: (context, index) {
                      final item = controller.toTrash[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AssetEntityImage(
                              item.entity,
                              isOriginal: false,
                              thumbnailSize: const ThumbnailSize.square(300),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item.formattedSize,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Safe Notice & Confirm Button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.safeNotice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textDarkSecondary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () async {
                                  final freedBytes = controller.totalTrashBytes;
                                  final success = await controller.commitPurge();
                                  if (success && context.mounted) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => CelebrationScreen(
                                          freedBytes: freedBytes,
                                        ),
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.trashCoral,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: controller.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  AppStrings.confirmPurge,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
