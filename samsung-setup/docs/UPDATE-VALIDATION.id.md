# Validasi pembaruan Samsung — 26 Oktober 2026

Revisi preset 2: HIDE_BARS, FULLSCREEN, HIDE_BARS_AA dan FULLSCREEN_AA diubah
menjadi false sesuai permintaan pemilik. URL TV, kunci suara dan tema dipertahankan.
ZIP/checksum serta kedua PDF dibangun ulang. Langkah aktivasi Developer mode
Android Auto dan verifikasi checkbox Unknown sources ON kini tertulis eksplisit
di prompt lengkap, prompt per tahap, prompt resume dan panduan PDF. Langkah
Unknown sources sebelumnya sudah ada di panduan instalasi, tetapi belum eksplisit
di prompt pemasangan utama. Pengaturan AA ini tidak termasuk isi ZIP preferensi.

Pembaruan ini mengubah kit pemasangan/dokumentasi, bukan kode aplikasi Fermata.
Profil S23 lama tetap menjadi default untuk kompatibilitas skrip terdahulu.
Profil baru dipilih eksplisit dengan FERMATA_SETUP_PROFILE=s25-reported.

## Pemeriksaan yang dilakukan

- Seluruh skrip PowerShell lolos parser Windows PowerShell.
- APK Fermata 2.0.2 dan KingInstaller 2.4 diunduh dari rilis resmi. Ukuran/SHA256
  berkas cocok dengan digest GitHub yang dipatok pada lock profil baru.
- Semua APK, arsip source dan alat desktop kedua profil lolos pemeriksaan offline
  Get-Artifacts.ps1 -IncludeSources -IncludeOptional -VerifyOnly.
- Integrasi Prepare-Phone.ps1 diuji dengan ADB tiruan untuk kedua profil:
  KingInstaller yang sesuai dipasang, APK Fermata dengan nama profil yang benar
  serta preset disalin ke Download. Tidak ada adb install untuk Fermata.
  Pengujian ini tidak mengakses atau mengubah HP nyata.
- Preset diperiksa terhadap allowlist 17 kunci pada tiga XML, diperiksa SHA256-nya,
  lalu dibangun ulang dan hasil byte ZIP identik.
- URL TV asli dipertahankan persis. Timestamp/ETag playlist, riwayat, favorit,
  WebView, ID internal dan metadata sesi tidak berada di preset publik.
- PDF dibuat dari Markdown panduan beserta lampiran prompt per tahap. Teks dan
  batas halaman diperiksa, serta halaman dirender untuk pemeriksaan tata letak.
- Tautan lokal pada dokumentasi baru diperiksa. git diff --check lulus.

## Belum diverifikasi pada perangkat

ZIP publik yang sudah dibersihkan belum diimpor langsung ke HP. Pengaturan inti
berasal dari cadangan pengguna, tetapi hasil impor bersih tetap harus diperiksa
setelah aplikasi ditutup dan dibuka ulang. Izin mikrofon/Android Auto bukan isi ZIP.

Keberhasilan S25 Ultra/Android 17/AA 17.9 merupakan laporan pengguna. Agent belum
memeriksa model code, One UI, patch/build lengkap, metode KingInstaller, field
installer atau hasil tiap fitur pada perangkat tersebut. Pengujian ulang S23 tidak
dijalankan sebagai bagian dari pembaruan dokumentasi ini.

Hasil berbagai Samsung lain belum ada. FS Mirror 2.0.2 dinonaktifkan menurut
upstream. Keberhasilan video bukan bukti mirroring; keberhasilan DHU bukan bukti
head unit mobil. Kit tidak mengubah pembatasan kendaraan.

## Membangun ulang dokumen dan preset

```powershell
py -m pip install reportlab
py samsung-setup/scripts/Build-Guide.py
py samsung-setup/preferences/build_preset.py
```

ReportLab hanya diperlukan untuk membangun PDF; pengguna instalasi tidak harus
memasangnya. ZIP preset dibangun memakai standard library Python. XML publik
adalah sumber preset; cadangan pribadi pemilik tidak diperlukan dan tidak disimpan
di Git. Panduan manual pribadi disimpan di luar repo dan tidak dipublikasikan.
