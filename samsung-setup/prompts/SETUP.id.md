# Prompt untuk agen Android QA / Automation

Salin isi blok berikut ke agen yang memiliki akses terminal Windows dan ADB:

```text
Bertindak sebagai Android QA & Automation Engineer. Saya mengizinkan pemasangan
dan konfigurasi Fermata Auto menggunakan kit di folder samsung-setup pada repo ini.
HP tersambung melalui Wireless debugging. Kerjakan sampai pengujian yang dapat
dilakukan selesai; bila ada batas nyata, laporkan bukti dan pekerjaan tersisa.

BACA DULU:
- samsung-setup/README.id.md
- samsung-setup/versions.lock.json
- samsung-setup/docs/INSTALL.id.md
- samsung-setup/docs/VERIFIED.id.md

BASELINE YANG SUDAH BERHASIL:
Samsung Galaxy S23 SM-S911B arm64, Android 16 / One UI 8.5,
Android Auto 17.8.663874-release, Fermata Auto 2.0.1 arm64 resmi,
KingInstaller 2.3 metode biasa, dan DHU 2.1 preview Windows.
Shizuku 13.6.0 disertakan sebagai opsi cadangan; bukan syarat jalur berhasil.
Jangan menyamakan hasil build ulang fork dengan APK resmi yang diuji.

BATAS:
- Jangan root, unlock bootloader, uninstall Fermata, hapus data, atau downgrade
  Android Auto. Jika tindakan berisiko kehilangan data diperlukan, siapkan backup
  konkret dan jelaskan alasan sebelum meminta persetujuan khusus.
- Jangan otomatis memakai versi terbaru; patuhi versi, ukuran, dan SHA256 lock.
- Jangan memasang Fermata dengan adb install/pm install -i sebagai pengganti
  KingInstaller: itu dapat mengembalikan initiator ke com.android.shell.
- Targetkan perangkat eksplisit dan user 0; jangan mengakses Secure Folder.
- Jangan membaca email, akun, galeri, atau file pribadi yang tidak diperlukan.
- Jangan memublikasikan log atau screenshot pribadi. Pakai laporan ringkas yang
  disanitasi. Jangan mencetak token atau credential.
- Jika alat menolak perintah, bedakan penolakan alat dari Auto Blocker Samsung.
  Jangan menyatakan HP menolak APK bila perintah belum sampai ke HP.

LANGKAH:
1. Temukan ADB, jalankan adb devices -l, pilih koneksi wireless yang aktif.
   Jangan mematok IP, port, serial, PID, display ID, atau koordinat sesi lama.
   Catat model, Android, ABI, serta versi AA dan Fermata yang sekarang terpasang.
2. Jalankan Get-Artifacts.ps1 -IncludeOptional dan verifikasi seluruh checksum.
   Untuk kit offline gunakan -VerifyOnly -IncludeOptional agar tidak mengunduh.
   Jalankan Install-DesktopTools.ps1 bila ADB/DHU kit belum diekstrak.
3. Audit instalasi saat ini dengan Verify-Phone.ps1. Jika versi dan catatan
   installer sudah sesuai, pertahankan dan langsung lakukan uji fungsional.
4. Bila perlu memasang ulang, jalankan Prepare-Phone.ps1. Gunakan KingInstaller
   classic dahulu, semua switch OFF. Pilih APK Fermata 2.0.1 arm64, Install as
   king, Package installer, Just once, lalu Install atau Update versi sama.
   Pertahankan data. Jika sudah ada versi lebih baru, berhenti untuk merencanakan
   backup alih-alih uninstall/downgrade diam-diam.
5. Pada otomasi DeX, periksa display, paket layar, dan bounds sebelum ketukan.
   Gunakan dump XML baru. Jika dump gagal, jangan memakai file lama atau mengetuk
   koordinat kosong. Periksa screenshot display yang benar. Selesaikan izin
   instalasi/media yang relevan; jangan mengaktifkan semua permission tanpa alasan.
6. Audit kembali. Pola yang dicapai pada perangkat teruji:
   installerPackageName=com.android.vending
   initiatingPackageName=com.google.android.packageinstaller
   originatingPackageName=com.example.kinginstaller
   Installer vending saja, atau initiator sekadar bukan shell, tidak cukup untuk
   mengklaim penerimaan Android Auto. Jika sudah cocok, jangan lanjut Shizuku.
7. Hanya jika classic gagal, install/jalankan Shizuku melalui Start-Shizuku.ps1,
   izinkan akses KingInstaller, coba metode Shizuku, kemudian audit lagi. Jangan
   klaim metode ini pasti bekerja pada semua Samsung. Hindari polling tak terbatas.
8. Buka Fermata, pastikan izin fitur yang diuji tersedia, periksa service dan
   proses. Jangan membersihkan logcat sebelum bukti masalah sempat disimpan secara
   terbatas. Bedakan crash Fermata dari crash Android Auto atau aplikasi lain.
9. Di Android Auto aktifkan Start head unit server, lalu Start-DHU.ps1. Jalankan
   DHU terlihat di laptop. Pilih Fermata Auto ikon play biru, bukan hanya Media
   Service atau FS Mirror. Buka YouTube dan uji video. Verifikasi perubahan adegan,
   status PLAYING, dan pause/resume. Thumbnail atau PID hidup bukan bukti video.
10. Jika diminta, uji mobil terpisah saat parkir. Keberhasilan DHU tidak membuktikan
    validasi production head unit. Unknown sources membantu media, tetapi tidak
    otomatis membuka komponen proyeksi. FS Mirror adalah pengujian terpisah.

LAPORAN AKHIR:
Tabel versi, tiga field installer, service, runtime/crash, gambar video di DHU,
play/pause, dan status pengujian mobil. Tandai BELUM DIUJI jika tidak ada bukti.
Jelaskan perubahan yang dilakukan dan batas hasilnya. Simpan bukti lokal yang
relevan; jangan upload data perangkat. Jangan menyatakan semua tes lulus bila
simulator atau mobil belum berhasil. Lanjutkan tindakan rutin yang sudah saya
izinkan tanpa meminta konfirmasi ulang.
```
