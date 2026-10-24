# Validasi kit

Pemeriksaan pada Windows 10 / Windows PowerShell 5.1, 24 Oktober 2026:

- Seluruh skrip PowerShell berhasil diparse.
- Ukuran dan SHA256 lima paket cocok dengan versions.lock.json.
- Arsip ADB dan DHU berhasil diekstrak ke artifacts; `adb version` melaporkan
  37.0.1 dan `desktop-head-unit --version` melaporkan 2.1-windows.
- Verify-Phone.ps1 berhasil membaca perangkat yang tersambung, versi Fermata dan
  Android Auto, ketiga field installer yang benar, service, dan izin media/overlay.
  Skrip tanpa -Launch tidak membuka aplikasi; ProcessAlive dapat false bila
  pengguna telah menutup aplikasi. Ini tidak diubah menjadi klaim lulus runtime.
- Prepare-Phone.ps1, Start-Shizuku.ps1, dan Install-DesktopTools.ps1 diuji dengan
  -WhatIf. Mode ini tidak memasang ulang aplikasi atau memulai daemon di HP.
- Runtime dan video aktual diuji pada sesi instalasi sebelumnya; lihat VERIFIED.id.md.
- Kode aplikasi upstream tidak diubah; build ulang Android tidak dijalankan.

File audit perangkat yang dihasilkan skrip tetap berada di reports/ yang diabaikan
Git. Publikasi ke GitHub memerlukan akun terhubung dan diperiksa terpisah dari
keberhasilan clone, commit, tag, dan bundle lokal.
