import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../models/media_item.dart';
import '../controllers/swipe_deck_controller.dart';
import 'purge_review_screen.dart';

class SwipeDeckScreen extends StatelessWidget {
  final CleanupCategory category;

  const SwipeDeckScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          Consumer<SwipeDeckController>(
            builder: (context, controller, child) {
              if (controller.toTrash.isEmpty) return const SizedBox.shrink();
              return TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PurgeReviewScreen(),
                    ),
                  );
                },
                icon:
                    const Icon(Icons.delete_sweep, color: AppColors.trashCoral),
                label: Text(
                  '${controller.toTrash.length}',
                  style: const TextStyle(
                    color: AppColors.trashCoral,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<SwipeDeckController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 64, color: AppColors.keepEmerald),
                  SizedBox(height: 16),
                  Text(
                    'All Clean!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          if (!controller.hasMore) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cleaning_services,
                        size: 64, color: AppColors.primaryBlue),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.reviewTitle,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${controller.toTrash.length} ${AppStrings.itemsSelected} (${controller.formattedTrashSize})',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: AppColors.textDarkSecondary),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const PurgeReviewScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.trashCoral,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          AppStrings.finishBatch,
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
            );
          }

          final currentItem = controller.items[controller.currentIndex];

          return SafeArea(
            child: Column(
              children: [
                // Top Progress & Undo Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${controller.currentIndex + 1} / ${controller.items.length}',
                        style: const TextStyle(
                          color: AppColors.textDarkSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.canUndo ? controller.undo : null,
                        icon: Icon(
                          Icons.undo,
                          color: controller.canUndo
                              ? AppColors.primaryBlue
                              : AppColors.textDarkSecondary
                                  .withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),

                // Card Stack Area
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Dismissible(
                      key: ValueKey(currentItem.entity.id),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          controller.swipeLeft(currentItem);
                        } else if (direction == DismissDirection.startToEnd) {
                          controller.swipeRight(currentItem);
                        }
                      },
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 32),
                        decoration: BoxDecoration(
                          color: AppColors.keepEmerald.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check,
                                color: AppColors.keepEmerald, size: 36),
                            const SizedBox(width: 8),
                            Text(
                              AppStrings.swipeRightKeep,
                              style: const TextStyle(
                                color: AppColors.keepEmerald,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 32),
                        decoration: BoxDecoration(
                          color: AppColors.trashCoral.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppStrings.swipeLeftTrash,
                              style: const TextStyle(
                                color: AppColors.trashCoral,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.delete_outline,
                                color: AppColors.trashCoral, size: 36),
                          ],
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AssetEntityImage(
                              currentItem.entity,
                              isOriginal: false,
                              thumbnailSize: const ThumbnailSize.square(800),
                              fit: BoxFit.contain,
                            ),
                            // Meta Data Pill
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentItem.formattedSize,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${currentItem.createDateTime.day}.${currentItem.createDateTime.month}.${currentItem.createDateTime.year}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Action Buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Trash Button
                      FloatingActionButton.large(
                        heroTag: 'trash_btn',
                        onPressed: () => controller.swipeLeft(currentItem),
                        backgroundColor:
                            AppColors.trashCoral.withValues(alpha: 0.15),
                        elevation: 0,
                        shape: const CircleBorder(
                          side:
                              BorderSide(color: AppColors.trashCoral, width: 2),
                        ),
                        child: const Icon(Icons.delete_outline,
                            color: AppColors.trashCoral, size: 36),
                      ),
                      // Keep Button
                      FloatingActionButton.large(
                        heroTag: 'keep_btn',
                        onPressed: () => controller.swipeRight(currentItem),
                        backgroundColor:
                            AppColors.keepEmerald.withValues(alpha: 0.15),
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide(
                              color: AppColors.keepEmerald, width: 2),
                        ),
                        child: const Icon(Icons.check,
                            color: AppColors.keepEmerald, size: 36),
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
