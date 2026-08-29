import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';
import '../models/media_item.dart';

class PhotoService {
  static Future<bool> requestPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    return ps.isAuth || ps.hasAccess;
  }

  static Future<bool> hasPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    return ps.isAuth || ps.hasAccess;
  }

  /// Fetches items based on selected category
  static Future<List<MediaItem>> fetchCategoryItems({
    required CleanupCategory category,
    int page = 0,
    int size = 50,
  }) async {
    try {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        type: category == CleanupCategory.largeVideos
            ? RequestType.video
            : RequestType.common,
        filterOption: FilterOptionGroup(
          orders: [
            const OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );

      if (paths.isEmpty) return [];

      AssetPathEntity targetPath = paths.first; // Default to Recent

      if (category == CleanupCategory.screenshots) {
        final screenshotPath = paths.firstWhere(
          (p) =>
              p.name.toLowerCase().contains('screenshot') ||
              p.name.toLowerCase().contains('ekran görüntüsü') ||
              p.name.toLowerCase().contains('bildschirmfoto') ||
              p.name.toLowerCase().contains('captura'),
          orElse: () => paths.first,
        );
        targetPath = screenshotPath;
      }

      final List<AssetEntity> entities =
          await targetPath.getAssetListPaged(page: page, size: size);

      List<MediaItem> mediaItems = [];
      for (final entity in entities) {
        int fileSize = 0;
        final file = await entity.file;
        if (file != null) {
          fileSize = await file.length();
        } else {
          // Fallback approximate estimation if file descriptor isn't loaded immediately
          fileSize = (entity.width * entity.height * (entity.type == AssetType.video ? 4 : 2));
        }

        // For large videos filter only 50MB+
        if (category == CleanupCategory.largeVideos && fileSize < 50 * 1024 * 1024) {
          continue;
        }

        mediaItems.add(
          MediaItem(
            entity: entity,
            sizeInBytes: fileSize,
            createDateTime: entity.createDateTime,
            isVideo: entity.type == AssetType.video,
          ),
        );
      }

      return mediaItems;
    } catch (e) {
      debugPrint('Error fetching media: $e');
      return [];
    }
  }

  /// Safely deletes assets through native OS Recently Deleted dialog
  static Future<List<String>> deleteAssets(List<AssetEntity> assets) async {
    try {
      final List<String> ids = assets.map((a) => a.id).toList();
      final result = await PhotoManager.editor.deleteWithIds(ids);
      return result;
    } catch (e) {
      debugPrint('Error deleting assets: $e');
      return [];
    }
  }
}
