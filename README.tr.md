<p align="center">
  <img src="data/icons/hicolor/scalable/apps/io.github.AcikKaynakGelistirmeToplulugu.ro-control.svg" width="128" height="128" alt="ro-Control">
</p>

<h1 align="center">ro-Control</h1>

<p align="center">
  <strong>Linux için Akıllı GPU Sürücü Yöneticisi</strong>
</p>

<p align="center">
  <a href="https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-control/releases"><img src="https://img.shields.io/github/v/release/Acik-Kaynak-Gelistirme-Toplulugu/ro-control?style=flat-square&color=blue" alt="Sürüm"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/lisans-GPL--3.0-green?style=flat-square" alt="Lisans"></a>
  <a href="https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-control/actions"><img src="https://img.shields.io/github/actions/workflow/status/Acik-Kaynak-Gelistirme-Toplulugu/ro-control/ci.yml?style=flat-square&label=CI" alt="CI"></a>
  <img src="https://img.shields.io/badge/platform-Fedora%20Linux-51A2DA?style=flat-square" alt="Fedora">
</p>

<p align="center">
  <a href="#özellikler">Özellikler</a> •
  <a href="#kurulum">Kurulum</a> •
  <a href="#kaynak-koddan-derleme">Derleme</a> •
  <a href="#katkı">Katkı</a> •
  <a href="#lisans">Lisans</a>
</p>

<p align="center">
  <a href="README.md"><img src="https://img.shields.io/badge/README-English-blue?style=flat-square" alt="README in English"></a>
  <a href="README.tr.md"><img src="https://img.shields.io/badge/README-T%C3%BCrk%C3%A7e-red?style=flat-square" alt="README in Turkish"></a>
</p>

---

ro-Control, Linux üzerinde GPU sürücü yönetimini kolaylaştıran yerel bir masaüstü uygulamasıdır; Fedora ve benzeri dağıtımlarda NVIDIA sürücülerini kurma, yapılandırma ve izleme süreçlerini sadeleştirir.

## Özellikler

### 🚀 Akıllı Sürücü Yönetimi

- **Hızlı Kurulum** — RPM Fusion (`akmod-nvidia`) ile tek tık NVIDIA sürücü kurulumu
- **Uzman Modu** — Proprietary ve Open Kernel modülleri arasında seçim
- **Derin Temizlik** — Eski sürücü kalıntılarını kaldırma
- **Secure Boot** — İmzalı/imzasız modül durumunu algılama ve uyarı

### 📊 Canlı Performans İzleme

- Gerçek zamanlı GPU sıcaklığı, yük ve VRAM kullanımı
- CPU yük ve sıcaklık takibi
- RAM kullanım takibi
- Renk kodlu ilerleme göstergeleri

### 🎮 Oyun Optimizasyonu

- **Feral GameMode** kurulumu ve yönetimi
- **Flatpak/Steam** izin onarım araçları

### 🖥 Görüntü Sunucusu

- **Wayland Düzeltmesi** — `nvidia-drm.modeset=1` parametresini kolay uygulama
- **Hibrit Grafik Profilleri** — NVIDIA/Intel/On-Demand geçiş desteği

### 🔄 Otomatik Güncelleme

- GitHub Releases üzerinden güncelleme kontrolü
- RPM paket indirip yükleme akışı

### 🌍 Çoklu Dil Desteği

- İngilizce ve Türkçe arayüz
- Genişletilebilir çeviri sistemi

## Kurulum

### Fedora (RPM)

En güncel sürümü [Releases](https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-control/releases) sayfasından indirip kurabilirsiniz:

```bash
sudo dnf install ./ro-control-1.0.0-1.fc*.x86_64.rpm
```

### Kaynaktan

```bash
sudo dnf install cargo cmake extra-cmake-modules gcc-c++ \
  kf6-qqc2-desktop-style \
  qt6-qtdeclarative-devel \
  qt6-qtbase-devel \
  qt6-qtwayland-devel

git clone https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-control.git
cd ro-control
make build
sudo make install
```

Detaylı derleme adımları için: [docs/BUILDING.md](docs/BUILDING.md)

## Kullanım

Uygulamayı menüden veya terminalden başlatabilirsiniz:

```bash
ro-control
```

> Not: Sürücü işlemleri PolicyKit üzerinden yönetici yetkisi gerektirir.

## Proje Yapısı

```text
ro-control/
├── src/                    # Uygulama kaynak kodu
│   ├── core/               # İş mantığı (tespit, kurulum, izleme)
│   ├── qml/                # Arayüz dosyaları
│   └── utils/              # Yardımcı modüller
├── data/                   # FreeDesktop veri dosyaları
├── packaging/              # RPM/Flatpak paketleme dosyaları
├── scripts/                # Yardımcı scriptler
├── po/                     # Çeviri dosyaları
├── docs/                   # Dokümantasyon
├── .github/                # CI/CD ve issue şablonları
├── Cargo.toml
├── Makefile
└── README.md
```

## Katkı

Katkılarınızı memnuniyetle karşılıyoruz. Pull request açmadan önce lütfen [CONTRIBUTING.md](CONTRIBUTING.md) dosyasını inceleyin.

## Lisans

Bu proje [GPL-3.0](LICENSE) lisansı ile dağıtılmaktadır.

---

<div align="center">
  <sub>❤️ ile geliştirildi — <a href="https://github.com/Acik-Kaynak-Gelistirme-Toplulugu">Açık Kaynak Geliştirme Topluluğu</a></sub>
</div>
