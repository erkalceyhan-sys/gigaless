import 'package:photo_manager/photo_manager.dart';

enum CleanupCategory {
  screenshots,
  duplicates,
  largeVideos,
  monthly,
  quickClean,
}

class MediaItem {
  final AssetEntity entity;
  final int sizeInBytes;
  final DateTime createDateTime;
  final bool isVideo;

  MediaItem({
    required this.entity,
    required this.sizeInBytes,
    required this.createDateTime,
    required this.isVideo,
  });

  String get formattedSize {
    if (sizeInBytes >= 1024 * 1024 * 1024) {
      return '${(sizeInBytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    } else if (sizeInBytes >= 1024 * 1024) {
      return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(sizeInBytes / 1024).toStringAsFixed(0)} KB';
    }
  }
}
