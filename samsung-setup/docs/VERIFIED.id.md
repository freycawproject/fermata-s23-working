# Hasil pengujian yang disanitasi

Tanggal: 24 Oktober 2026, zona Asia/Bangkok. Pengujian menggunakan perangkat asli
yang tersambung lewat Wireless ADB dan DHU pada Windows.

| Pemeriksaan | Hasil yang diamati |
|---|---|
| Fermata | 2.0.1 arm64, APK resmi sesuai digest GitHub |
| KingInstaller | 2.3, APK resmi sesuai digest GitHub |
| Cara pemasangan | Classic > Google Package Installer > Update versi sama |
| Installer | com.android.vending |
| Initiator | com.google.android.packageinstaller |
| Originator | com.example.kinginstaller |
| Data aplikasi | Tidak di-uninstall atau dihapus |
| Izin | Overlay, audio/video media, mikrofon, notifikasi tetap aktif |
| Service | CarAppService / MediaBrowserService terdaftar; CarService di-bind DHU |
| Runtime | Proses hidup; tidak ditemukan crash Fermata pada crash buffer yang diperiksa |
| DHU | 2.1 preview Windows, 1280x720; UI Android Auto dan Fermata tampil |
| Video | YouTube diputar; perubahan adegan terlihat dan status PLAYING diamati |
| Kontrol | Play dan pause diuji; playback dilanjutkan pada pengujian berikutnya |
| Shizuku | Tidak dipakai untuk pemasangan yang berhasil |
| Head unit mobil | Belum diverifikasi |
| FS Mirror | Belum diverifikasi; permintaan unlock/izin terpisah |
| Audio terdengar | Tidak diukur secara independen |

Ini laporan hasil observasi, bukan jaminan kompatibilitas semua versi/HP. Data
mentah berisi serial, email, IP, notifikasi, dan layar pribadi tidak disertakan
dalam repo atau paket publik.
