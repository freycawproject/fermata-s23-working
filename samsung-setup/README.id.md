# Fermata Samsung S23: paket konfigurasi teruji

Paket ini merekam hasil pemasangan dan pengujian **24 Oktober 2026**. Source
Fermata berasal dari tag **2.0.1**, commit
`7be970dbc1d68f674886af3e9a4e4ad838e56bc4`; kode aplikasi upstream tidak diubah.
APK yang digunakan adalah **rilis resmi**, bukan APK hasil kompilasi fork ini.

## Konfigurasi yang berhasil

| Komponen | Versi / peran |
|---|---|
| HP | Samsung Galaxy S23 SM-S911B, arm64 |
| Android / One UI | Android 16 / One UI 8.5 |
| Android Auto | 17.8.663874-release; tidak diturunkan versinya |
| Fermata Auto | **2.0.1 arm64** |
| KingInstaller | **2.3**, metode biasa, tanpa pilihan Root/Shizuku/Oppo |
| Shizuku | 13.6.0.r1086.2650830c, disertakan sebagai **cadangan opsional** |
| ADB Platform Tools | 37.0.1 untuk Windows |
| DHU | **2.1 preview Windows**, konfigurasi `default_720p.ini` |

Hasil yang benar-benar diamati:

- Fermata dipasang melalui KingInstaller > Google Package Installer > Update.
  Pemasangan menimpa versi yang sama; tidak ada uninstall atau hapus data.
- `installerPackageName=com.android.vending`.
- `initiatingPackageName=com.google.android.packageinstaller`.
- `originatingPackageName=com.example.kinginstaller`.
- Fermata Auto tampil di launcher DHU, UI khusus terbuka, dan video YouTube
  menampilkan adegan bergerak. Status media `PLAYING`, lalu `PAUSED` saat diuji.
- Shizuku, root, dan InstallWithOptions **tidak dibutuhkan** pada jalur berhasil ini.

**Batas pengujian:** head unit mobil fisik belum diverifikasi; DHU adalah head unit
pengembang dengan perilaku validasi berbeda. FS Mirror memiliki permintaan izin
terpisah dan belum diverifikasi. Audio terdengar tidak diukur secara independen;
yang diamati ialah gambar dan status sesi media. Model/patch lain bisa berbeda.

## Mulai dari Windows

Buka PowerShell di folder `samsung-setup`:

Jika Windows menolak eksekusi skrip lokal, buka proses PowerShell khusus kit ini
dengan `powershell.exe -NoProfile -ExecutionPolicy RemoteSigned`, lalu jalankan
perintah di bawah dari proses itu. Opsi ini hanya berlaku pada proses tersebut;
kit tidak mengubah kebijakan mesin atau registry. Jangan gunakan cara ini untuk
mengabaikan Group Policy organisasi. Jika arsip dari internet ditandai sebagai
file unduhan, tinjau source terlebih dahulu dan ikuti kebijakan Windows setempat.

```powershell
# Lewati unduhan jika memakai ZIP offline; tetap periksa checksum.
.\scripts\Get-Artifacts.ps1 -IncludeOptional
.\scripts\Install-DesktopTools.ps1

# Hubungkan Wireless debugging terlebih dahulu. Gunakan port koneksi,
# bukan port pairing. Port dan serial tidak dipatok ke HP pemilik repo.
.\artifacts\platform-tools\adb.exe devices -l

# Menyiapkan KingInstaller dan menyalin Fermata; tidak memasang Fermata via shell.
.\scripts\Prepare-Phone.ps1
```

Untuk memverifikasi seluruh isi ZIP offline termasuk source KingInstaller dan
Shizuku, jalankan `Get-Artifacts.ps1 -IncludeOptional -IncludeSources -VerifyOnly`.
Untuk mengambil source tersebut dari repo Git saja, gunakan `-IncludeSources`
tanpa `-VerifyOnly`. Source Fermata sudah berada di repo ini.

Lanjutkan **[panduan instalasi](docs/INSTALL.id.md)** di layar HP. Bila ADB
menampilkan lebih dari satu koneksi, berikan `-Serial '<serial dari adb devices>'`
pada skrip. `-AdbPath` dapat menunjuk ADB dari SDK yang sudah ada.

```powershell
# Audit instalasi dan jalankan aplikasi tanpa menghapus log/data.
.\scripts\Verify-Phone.ps1 -Launch -OutFile .\reports\verification.json

# Di HP: Android Auto > menu > Start head unit server.
.\scripts\Start-DHU.ps1
```

Di DHU, buka launcher, gulir ke **Fermata Auto dengan ikon play biru**, buka
YouTube, dan putar video. Pastikan adegan berganti; gambar thumbnail, PID hidup,
atau service terdaftar saja tidak cukup. Uji koneksi mobil secara terpisah saat
parkir. Tutup DHU sebelum menguji koneksi mobil jika keduanya berebut sesi.

## Jalur cadangan Shizuku

Gunakan hanya jika metode biasa gagal pada perangkat lain:

```powershell
.\scripts\Get-Artifacts.ps1 -IncludeOptional
.\scripts\Prepare-Phone.ps1 -IncludeShizuku
.\scripts\Start-Shizuku.ps1
```

Izinkan KingInstaller di Shizuku, kemudian coba switch Shizuku di KingInstaller.
Audit kembali hasilnya. Shizuku yang dijalankan lewat ADB memakai identitas shell;
itu bukan root dan tidak menjamin metadata installer yang diinginkan.

## Isi repo dan paket offline

- `versions.lock.json`: URL versi pasti, ukuran, dan SHA256; tidak memakai endpoint
  `latest`. SHA256 Shizuku berasal dari file resmi yang diunduh saat sesi awal;
  GitHub tidak menyediakan digest untuk asset itu.
- `scripts/`: unduh/verifikasi, siapkan HP, audit, jalankan Shizuku dan DHU.
- `prompts/SETUP.id.md`: prompt lengkap untuk mengulang setup melalui agen AI.
- `prompts/RESUME.id.md`: prompt singkat untuk melanjutkan perangkat yang sudah siap.
- `docs/VERIFIED.id.md`: laporan yang disanitasi, tanpa email, serial, IP, screenshot
  HP, token, atau logcat penuh.
- `licenses/`: lisensi upstream dan tautan sumber. Hak masing-masing komponen
  tetap milik pemiliknya.
- `artifacts/`: APK dan ZIP alat; tersedia dalam ZIP lokal atau diunduh oleh skrip,
  tetapi diabaikan Git agar riwayat repo tidak berisi binary besar.

InstallWithOptions tidak disertakan: percobaan sebelumnya masih menghasilkan
initiator `com.android.shell`. Fermata 2.0.2 juga tidak disertakan agar baseline
tidak berubah; penghapusan FS Mirror pada versi itu memang disengaja upstream.

## Fork dan build

Branch setup: `samsung-s23-working`. Remote `upstream` menunjuk source asli.
Lihat **[publikasi fork](docs/PUBLISH.id.md)**. Paket lokal menyertakan Git bundle
agar riwayat dapat dipulihkan tanpa GitHub. Membuat clone lokal belum membuat fork
di akun GitHub.

Petunjuk build upstream tetap ada di [README utama](../README.md). Build ulang
dapat memakai identitas/signature lain dan **tidak dianggap setara** dengan APK
rilis resmi yang diuji. Jangan mengubah package/signing atau mengganti APK tanpa
menjalankan ulang audit dan pengujian.

Referensi: [Fermata 2.0.1](https://github.com/AndreyPavlenko/Fermata/releases/tag/2.0.1),
[KingInstaller 2.3](https://github.com/fcaronte/KingInstaller/releases/tag/2.3),
[Shizuku 13.6.0](https://github.com/RikkaApps/Shizuku/releases/tag/v13.6.0),
[DHU Google](https://developer.android.com/training/cars/testing/dhu).
