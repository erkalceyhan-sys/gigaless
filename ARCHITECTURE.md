# ARCHITECTURE.md - Gigaless

Teknik Mimari, Bağımlılıklar, Güvenlik ve Klasör Yapısı.

---

## 1. Teknoloji Yığını (Tech Stack)
* **Framework:** Flutter 3.24+ (Dart 3.5+)
* **State Management:** Provider / ChangeNotifier (Hafif, sıfır boilerplate, ultra performanslı)
* **Cihaz Galerisi:** `photo_manager: ^3.1.4` (Hızlı thumbnail önbellekleme ve güvenli silme API'si)
* **Haptics:** `flutter/services.dart` (HapticFeedback - Light, Medium, Heavy)
* **Yerel Depolama:** `shared_preferences: ^2.3.2` (Kurtarılan MB sayacı ve kullanıcı tercihleri)
* **Reklam Ağı:** `google_mobile_ads: ^5.1.0` (AdMob Banner, Interstitial, Rewarded)
* **Paylaşım:** `share_plus: ^10.0.2` & `path_provider: ^2.1.4`

---

## 2. Klasör Yapısı (Project Structure)

```
gigaless/
├── app/
│   ├── lib/
│   │   ├── core/
│   │   │   ├── theme/          # Apple Dark & Light Obsidian Minimalist Teması
│   │   │   ├── l10n/           # 6 Dilli app_strings.dart (EN, DE, ES, FR, JA, TR)
│   │   │   ├── constants/      # Renkler, boyutlar, AdMob Test ID'leri
│   │   │   └── services/       # AdService, StorageService, HapticService
│   │   ├── features/
│   │   │   ├── gallery/
│   │   │   │   ├── models/     # MediaItem, AlbumCategory, CleanupSession
│   │   │   │   ├── services/   # PhotoManagerService (Cihaz içi tarama)
│   │   │   │   ├── controllers/# SwipeDeckController (Tinder kart mantığı)
│   │   │   │   ├── views/      # HomeScreen, SwipeDeckScreen, PurgeReviewScreen
│   │   │   │   └── widgets/    # SwipeCard, StorageRing, CategoryCard
│   │   │   ├── stats/          # SavedStorageScreen, ShareableMilestoneCard
│   │   │   └── settings/       # SettingsScreen, PrivacyPolicyView
│   │   └── main.dart
│   ├── assets/
│   ├── ios/
│   └── android/
├── .github/
│   └── workflows/              # GitHub Actions CI/CD (Android AAB & TestFlight)
├── PRODUCT_SPEC.md
└── ARCHITECTURE.md
```

---

## 3. Gizlilik ve Güvenlik İlkeleri (Privacy First)
1. **Sıfır Bulut Gönderimi:** Kullanıcının hiçbir fotoğrafı, videosu veya meta verisi hiçbir sunucuya yüklenmez. Tüm işlemler %100 kullanıcının telefonunda gerçekleşir.
2. **Korumalı Silme:** Fotoğraflar asla doğrudan kalıcı olarak silinmez; işletim sisteminin native çöp kutusuna taşınır. Kullanıcı dilediğinde 30 gün içinde galerisinden geri kurtarabilir.
