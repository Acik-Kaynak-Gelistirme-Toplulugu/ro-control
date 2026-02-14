# Version Notes

Bu dosya, her sürümde yapılan değişikliklerin kısa ve takip edilebilir özetini tutar.
Yeni bir sürüm çıktığında bu dosyada en üste yeni bir bölüm eklenmeli ve eski bölümler korunmalıdır.

## Güncelleme Kuralı

- Yeni sürüm çıktığında en üste `## [x.y.z] - YYYY-MM-DD` başlığı ekleyin.
- Aşağıdaki başlıkları kullanın: `Added`, `Changed`, `Fixed`, `Removed`.
- Mümkün olduğunca kullanıcıya etkisi olan değişiklikleri yazın.
- Her sürüm için release bağlantısı ekleyin.

---

## [1.0.0] - 2026-02-14

### Added
- Rust + Qt6 tabanlı yeni masaüstü mimarisi
- NVIDIA sürücü kurulum/kaldırma akışları
- Express ve Expert kurulum modları
- GPU/CPU/RAM canlı izleme ekranı
- Secure Boot kontrolü ve uyarı akışı
- Güncelleme kontrolü (GitHub Releases)

### Changed
- Fedora/RPM Fusion odaklı sürücü yönetimi
- Arayüz bileşenlerinde okunabilirlik ve düzen iyileştirmeleri
- QML sayfa yapısı (Install / Expert / Monitor / Progress) sadeleştirildi

### Fixed
- Qt/QML açılış hataları ve tip/import uyumsuzlukları giderildi
- Logger başlatma API uyumsuzluğu giderildi

### Removed
- Eski web arayüzü kalıntıları
- Kullanılmayan platform/senaryo bağımlılıkları

Release: https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-Control/releases/tag/v1.0.0

---

## Şablon

```markdown
## [x.y.z] - YYYY-MM-DD

### Added
- ...

### Changed
- ...

### Fixed
- ...

### Removed
- ...

Release: https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-Control/releases/tag/vx.y.z
```
