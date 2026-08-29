# PRODUCT_SPEC.md - Gigaless

**Gigaless: Photo & Storage Tidy**  
*Slogan:* "Swipe to Free Your Storage"

---

## 1. Ürün Özeti & Vizyon
Gigaless; iOS ve Android kullanıcılarının cihazlarında biriken ekran görüntülerini (screenshots), benzer/çift fotoğrafları ve büyük videoları saniyeler içinde temizlemelerini sağlayan minimalist, ultra akıcı bir galeri detoks uygulamasıdır.

Piyasadaki rakiplerin (yıllık 30-50$ abonelik dayatan) aksine Gigaless; %100 yerel (on-device) çalışan, kullanıcı gizliliğine saygılı, reklamlara boğmayan ve sade bir kullanıcı deneyimi sunar.

---

## 2. Temel Kullanıcı Akışı (User Flow)

1. **İzin ve Hızlı Karşılama:**
   * Kullanıcıdan sadece fotoğraf kütüphanesi okuma/yazma izni istenir.
   * Cihazdaki görseller taranır (Buluta hiçbir veri yüklenmez).
2. **Kategori Seçimi (Ana Hub):**
   * **Screenshots (Ekran Görüntüleri):** En hızlı yer açılan çöp havuzu.
   * **Duplicates & Bursts (Benzer Fotoğraflar):** Aynı anın tekrarları.
   * **Large Videos (Büyük Videolar):** 50MB+ yer kaplayan videolar.
   * **Month by Month (Ay Ay Temizlik):** Geçmiş ayların fotoğraflarını sırayla detoks etme.
3. **Swipe Temizleme Motoru (Tinder Mekaniği):**
   * **Sola Kaydır (Swipe Left):** Çöpe At (Kırmızı gösterge + hafif haptic).
   * **Sağa Kaydır (Swipe Right):** Sakla (Yeşil gösterge + hafif haptic).
   * **Yukarı Kaydır (Swipe Up):** Favorile / İnceleme için ayır.
   * **Geri Al (Undo Butonu):** Son yapılan seçimi anında geri getirme.
4. **Güvenli Silme Özeti (Review & Purge):**
   * Kullanıcı temizlik turunu bitirdiğinde seçilen fotoğrafların listesi ve toplam açılacak hafıza (Örn: "1.42 GB Boşaltılacak") gösterilir.
   * "Çöpü Boşalt" butonuna basıldığında Apple/Android'in resmi sistem çöp kutusu onay modalı açılır (Fotoğraflar doğrudan "Son Silinenler"e gider, veri kaybı riski sıfırdır).
5. **Kutlama & Tasarruf Kartı:**
   * "Tebrikler! 1.42 GB alan kurtardın." animasyonu.
   * Tek tıkla Instagram Story / WhatsApp'a atılabilecek şık minimalist paylaşım kartı.

---

## 3. Gelir Modeli (Monetization Architecture)

* **Banner Reklamlar:** Sonuç ekranı ve ayarlar altında sabit şık banner.
* **Geçiş Reklamları (Interstitial):** Her 25-30 swipe'lık temizlik turu tamamlandığında doğal bekleme anında gösterilir.
* **Ödüllü Reklamlar (Rewarded Video):** "Tüm galeriyi derinlemesine tara" veya "Tek tıkla tüm ekran görüntülerini seç" gibi gelişmiş filtreleri açmak için.
* **Opsiyonel "Gigaless Pro" (IAP / In-App Purchase):** Reklamsız kullanım + sınırsız derin tarama (Tek seferlik 4.99$ veya yıllık 9.99$).

---

## 4. Global ASO & Hedef Kitle
* **Hedef Bölgeler:** ABD, Almanya, Birleşik Krallık, Japonya, Fransa, İspanya, Türkiye.
* **Mağaza Anahtar Kelimeleri:**
  * `photo cleaner`, `clean storage`, `delete screenshots`, `swipe photos`, `duplicate photos`, `free up space iphone`, `gallery cleaner`, `icloud full fix`.
