import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keySavedBytes = 'gigaless_saved_bytes';
  static const String _keyCleanedSessions = 'gigaless_cleaned_sessions';

  static Future<int> getTotalSavedBytes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keySavedBytes) ?? 0;
  }

  static Future<void> addSavedBytes(int bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_keySavedBytes) ?? 0;
    final sessions = prefs.getInt(_keyCleanedSessions) ?? 0;
    await prefs.setInt(_keySavedBytes, current + bytes);
    await prefs.setInt(_keyCleanedSessions, sessions + 1);
  }

  static String formatBytes(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    } else if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / 1024).toStringAsFixed(0)} KB';
    }
  }
}
