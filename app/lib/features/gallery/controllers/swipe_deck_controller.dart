import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/media_item.dart';
import '../../../core/services/ad_service.dart';
import '../../../core/services/storage_service.dart';

class SwipeDeckController extends ChangeNotifier {
  List<MediaItem> _items = [];
  final List<MediaItem> _toTrash = [];
  final List<MediaItem> _toKeep = [];
  final List<Map<String, dynamic>> _history = []; // for undo

  int _currentIndex = 0;
  bool _isLoading = false;
  int _swipeCountSinceAd = 0;

  List<MediaItem> get items => _items;
  List<MediaItem> get toTrash => _toTrash;
  List<MediaItem> get toKeep => _toKeep;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  bool get hasMore => _currentIndex < _items.length;
  bool get canUndo => _history.isNotEmpty;

  int get totalTrashBytes => _toTrash.fold(0, (sum, item) => sum + item.sizeInBytes);

  String get formattedTrashSize {
    final bytes = totalTrashBytes;
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    } else if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / 1024).toStringAsFixed(0)} KB';
    }
  }

  void setItems(List<MediaItem> newItems) {
    _items = newItems;
    _currentIndex = 0;
    _toTrash.clear();
    _toKeep.clear();
    _history.clear();
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void swipeLeft(MediaItem item) {
    HapticFeedback.mediumImpact();
    _toTrash.add(item);
    _history.add({'action': 'trash', 'item': item});
    _currentIndex++;
    _checkAdTrigger();
    notifyListeners();
  }

  void swipeRight(MediaItem item) {
    HapticFeedback.lightImpact();
    _toKeep.add(item);
    _history.add({'action': 'keep', 'item': item});
    _currentIndex++;
    _checkAdTrigger();
    notifyListeners();
  }

  void undo() {
    if (_history.isEmpty || _currentIndex <= 0) return;
    HapticFeedback.selectionClick();
    final last = _history.removeLast();
    final item = last['item'] as MediaItem;
    final action = last['action'] as String;

    if (action == 'trash') {
      _toTrash.remove(item);
    } else if (action == 'keep') {
      _toKeep.remove(item);
    }
    _currentIndex--;
    notifyListeners();
  }

  void _checkAdTrigger() {
    _swipeCountSinceAd++;
    if (_swipeCountSinceAd >= 25) {
      _swipeCountSinceAd = 0;
      AdService.showInterstitialAd();
    }
  }

  Future<bool> commitPurge() async {
    if (_toTrash.isEmpty) return true;
    _isLoading = true;
    notifyListeners();

    final assetsToDelete = _toTrash.map((m) => m.entity).toList();
    final deletedIds = await PhotoService.deleteAssets(assetsToDelete);

    if (deletedIds.isNotEmpty) {
      // Record recovered storage
      await StorageService.addSavedBytes(totalTrashBytes);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
