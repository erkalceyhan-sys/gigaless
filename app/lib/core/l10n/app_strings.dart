enum AppLanguage {
  en,
  de,
  es,
  fr,
  ja,
  tr,
}

class AppStrings {
  static AppLanguage currentLanguage = AppLanguage.en;

  static void setLanguage(String code) {
    switch (code.toLowerCase()) {
      case 'de':
        currentLanguage = AppLanguage.de;
        break;
      case 'es':
        currentLanguage = AppLanguage.es;
        break;
      case 'fr':
        currentLanguage = AppLanguage.fr;
        break;
      case 'ja':
        currentLanguage = AppLanguage.ja;
        break;
      case 'tr':
        currentLanguage = AppLanguage.tr;
        break;
      default:
        currentLanguage = AppLanguage.en;
    }
  }

  // App General
  static String get appName => 'Gigaless';
  static String get appTagline => _get({
        AppLanguage.en: 'Swipe to Free Your Storage',
        AppLanguage.de: 'Wische, um Speicherplatz freizugeben',
        AppLanguage.es: 'Desliza para liberar espacio',
        AppLanguage.fr: 'Glissez pour libérer de l\'espace',
        AppLanguage.ja: 'スワイプでストレージを解放',
        AppLanguage.tr: 'Kaydır, Depolama Alanını Kurtar',
      });

  // Home Hub
  static String get storageSaved => _get({
        AppLanguage.en: 'Storage Recovered',
        AppLanguage.de: 'Speicher freigegeben',
        AppLanguage.es: 'Almacenamiento liberado',
        AppLanguage.fr: 'Stockage récupéré',
        AppLanguage.ja: '節約されたストレージ',
        AppLanguage.tr: 'Kurtarılan Alan',
      });

  static String get quickClean => _get({
        AppLanguage.en: 'Quick Clean',
        AppLanguage.de: 'Schnellreinigung',
        AppLanguage.es: 'Limpieza rápida',
        AppLanguage.fr: 'Nettoyage rapide',
        AppLanguage.ja: 'クイッククリーン',
        AppLanguage.tr: 'Hızlı Temizlik',
      });

  static String get categories => _get({
        AppLanguage.en: 'Categories',
        AppLanguage.de: 'Kategorien',
        AppLanguage.es: 'Categorías',
        AppLanguage.fr: 'Catégories',
        AppLanguage.ja: 'カテゴリー',
        AppLanguage.tr: 'Kategoriler',
      });

  static String get screenshots => _get({
        AppLanguage.en: 'Screenshots',
        AppLanguage.de: 'Screenshots',
        AppLanguage.es: 'Capturas de pantalla',
        AppLanguage.fr: 'Captures d\'écran',
        AppLanguage.ja: 'スクリーンショット',
        AppLanguage.tr: 'Ekran Görüntüleri',
      });

  static String get duplicates => _get({
        AppLanguage.en: 'Similar & Bursts',
        AppLanguage.de: 'Ähnliche Fotos',
        AppLanguage.es: 'Fotos similares',
        AppLanguage.fr: 'Photos similaires',
        AppLanguage.ja: '類似写真・連写',
        AppLanguage.tr: 'Benzer & Seri Çekimler',
      });

  static String get largeVideos => _get({
        AppLanguage.en: 'Large Videos',
        AppLanguage.de: 'Große Videos',
        AppLanguage.es: 'Videos grandes',
        AppLanguage.fr: 'Vidéos volumineuses',
        AppLanguage.ja: '大容量動画',
        AppLanguage.tr: 'Büyük Videolar',
      });

  static String get monthByMonth => _get({
        AppLanguage.en: 'Month by Month',
        AppLanguage.de: 'Monat für Monat',
        AppLanguage.es: 'Mes a mes',
        AppLanguage.fr: 'Mois par mois',
        AppLanguage.ja: '月別クリーン',
        AppLanguage.tr: 'Ay Ay Temizlik',
      });

  // Swipe Action HUD
  static String get swipeLeftTrash => _get({
        AppLanguage.en: 'TRASH',
        AppLanguage.de: 'LÖSCHEN',
        AppLanguage.es: 'BORRAR',
        AppLanguage.fr: 'SUPPRIMER',
        AppLanguage.ja: 'ゴミ箱',
        AppLanguage.tr: 'SİL',
      });

  static String get swipeRightKeep => _get({
        AppLanguage.en: 'KEEP',
        AppLanguage.de: 'BEHALTEN',
        AppLanguage.es: 'GUARDAR',
        AppLanguage.fr: 'GARDER',
        AppLanguage.ja: 'キープ',
        AppLanguage.tr: 'SAKLA',
      });

  static String get undo => _get({
        AppLanguage.en: 'Undo',
        AppLanguage.de: 'Rückgängig',
        AppLanguage.es: 'Deshacer',
        AppLanguage.fr: 'Annuler',
        AppLanguage.ja: '元に戻す',
        AppLanguage.tr: 'Geri Al',
      });

  static String get finishBatch => _get({
        AppLanguage.en: 'Review & Purge',
        AppLanguage.de: 'Überprüfen & Löschen',
        AppLanguage.es: 'Revisar y purgar',
        AppLanguage.fr: 'Vérifier et purger',
        AppLanguage.ja: '確認して削除',
        AppLanguage.tr: 'İncele ve Temizle',
      });

  // Review & Confirmation Screen
  static String get reviewTitle => _get({
        AppLanguage.en: 'Ready to Clean',
        AppLanguage.de: 'Bereit zum Löschen',
        AppLanguage.es: 'Listo para limpiar',
        AppLanguage.fr: 'Prêt à nettoyer',
        AppLanguage.ja: 'クリーンアップの準備完了',
        AppLanguage.tr: 'Temizliğe Hazır',
      });

  static String get itemsSelected => _get({
        AppLanguage.en: 'items marked for deletion',
        AppLanguage.de: 'Elemente zum Löschen markiert',
        AppLanguage.es: 'elementos marcados para borrar',
        AppLanguage.fr: 'éléments marqués pour suppression',
        AppLanguage.ja: '件の削除対象アイテム',
        AppLanguage.tr: 'öğe silinmek üzere seçildi',
      });

  static String get spaceToFree => _get({
        AppLanguage.en: 'Space to Free',
        AppLanguage.de: 'Freizugebender Speicher',
        AppLanguage.es: 'Espacio a liberar',
        AppLanguage.fr: 'Espace à libérer',
        AppLanguage.ja: '解放される容量',
        AppLanguage.tr: 'Açılacak Alan',
      });

  static String get confirmPurge => _get({
        AppLanguage.en: 'Empty Trash to Recently Deleted',
        AppLanguage.de: 'In "Zuletzt gelöscht" verschieben',
        AppLanguage.es: 'Mover a Eliminados recientemente',
        AppLanguage.fr: 'Déplacer vers Supprimés récemment',
        AppLanguage.ja: '「最近削除した項目」へ移動',
        AppLanguage.tr: 'Son Silinenlere Taşı ve Temizle',
      });

  static String get safeNotice => _get({
        AppLanguage.en:
            'Safe Deletion: Items move to your system Recently Deleted album. You can restore them anytime within 30 days.',
        AppLanguage.de:
            'Sicheres Löschen: Fotos werden in "Zuletzt gelöscht" verschoben und können 30 Tage lang wiederhergestellt werden.',
        AppLanguage.es:
            'Eliminación segura: Los elementos van a "Eliminados recientemente". Puedes restaurarlos en 30 días.',
        AppLanguage.fr:
            'Suppression sécurisée : Déplacé vers "Supprimés récemment". Restaurable pendant 30 jours.',
        AppLanguage.ja: '安心の安全削除：写真は「最近削除した項目」に移動します。30日以内であれば復元可能です。',
        AppLanguage.tr:
            'Güvenli Silme: Fotoğraflar sistemin "Son Silinenler" klasörüne taşınır. 30 gün içinde istediğiniz an geri yükleyebilirsiniz.',
      });

  // Success / Milestone
  static String get celebrationTitle => _get({
        AppLanguage.en: 'Storage Freed!',
        AppLanguage.de: 'Speicherplatz gewonnen!',
        AppLanguage.es: '¡Espacio liberado!',
        AppLanguage.fr: 'Espace libéré !',
        AppLanguage.ja: 'クリーンアップ完了！',
        AppLanguage.tr: 'Alan Kurtarıldı!',
      });

  static String get shareAchievement => _get({
        AppLanguage.en: 'Share Achievement',
        AppLanguage.de: 'Erfolg teilen',
        AppLanguage.es: 'Compartir logro',
        AppLanguage.fr: 'Partager l\'exploit',
        AppLanguage.ja: '結果をシェアする',
        AppLanguage.tr: 'Başarıyı Paylaş',
      });

  static String get done => _get({
        AppLanguage.en: 'Done',
        AppLanguage.de: 'Fertig',
        AppLanguage.es: 'Listo',
        AppLanguage.fr: 'Terminé',
        AppLanguage.ja: '完了',
        AppLanguage.tr: 'Tamam',
      });

  // Permission Screen
  static String get permissionTitle => _get({
        AppLanguage.en: 'Access Your Photos',
        AppLanguage.de: 'Zugriff auf deine Fotos',
        AppLanguage.es: 'Acceso a tus fotos',
        AppLanguage.fr: 'Accès à vos photos',
        AppLanguage.ja: '写真へのアクセス',
        AppLanguage.tr: 'Fotoğraflarına Eriş',
      });

  static String get permissionDesc => _get({
        AppLanguage.en:
            'Gigaless works 100% locally on your device. Your photos are never uploaded to any server.',
        AppLanguage.de:
            'Gigaless funktioniert 100% lokal auf deinem Gerät. Keine Fotos werden hochgeladen.',
        AppLanguage.es:
            'Gigaless funciona 100% en tu dispositivo. Tus fotos nunca se suben a ningún servidor.',
        AppLanguage.fr:
            'Gigaless fonctionne à 100% localement. Aucune photo n\'est envoyée sur un serveur.',
        AppLanguage.ja: 'Gigalessは完全に端末内で動作します。写真が外部サーバーに送信されることは一切ありません。',
        AppLanguage.tr:
            'Gigaless %100 cihazınızın üzerinde yerel çalışır. Fotoğraflarınız asla hiçbir sunucuya yüklenmez.',
      });

  static String get grantPermission => _get({
        AppLanguage.en: 'Grant Photo Access',
        AppLanguage.de: 'Zugriff erlauben',
        AppLanguage.es: 'Permitir acceso',
        AppLanguage.fr: 'Autoriser l\'accès',
        AppLanguage.ja: '写真へのアクセスを許可',
        AppLanguage.tr: 'Fotoğraf İzni Ver',
      });

  static String _get(Map<AppLanguage, String> map) {
    return map[currentLanguage] ?? map[AppLanguage.en] ?? '';
  }
}
