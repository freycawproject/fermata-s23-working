# Panduan instalasi Fermata Samsung melalui agent

Edisi 26 Oktober 2026 | Bahasa Indonesia | Kit komunitas, bukan dukungan resmi Samsung/Google

## 1. Hasil yang dituju

Agent membantu menyiapkan dan memasang Fermata melalui KingInstaller, mengimpor
preset publik yang menyertakan playlist TV Indonesia, lalu memverifikasi hasil.
Anda tetap membantu saat Android meminta izin atau dialog tidak dapat diakses agent.
Tidak diperlukan root pada jalur utama. Keberhasilan semua Samsung belum terbukti.

## 2. Siapkan perangkat dan komputer

Gunakan Windows dengan agent yang dapat menjalankan terminal dan ADB, koneksi
internet, HP Samsung dengan profil utama, serta kabel atau Wireless debugging.
Unduh/clone repo freycawproject/fermata-s23-working, branch samsung-s23-working.
Buka folder repo pada agent. Simpan cadangan preferensi jika Fermata sudah dipakai.
Jangan hapus instalasi yang sudah berfungsi.

Aktifkan Developer options melalui Settings > About phone > Software information >
ketuk Build number tujuh kali. Aktifkan Wireless debugging pada jaringan yang
sama, atau USB debugging untuk kabel. Setujui pairing/otorisasi komputer Anda.
Jangan membagikan kode pairing atau serial perangkat ke issue publik.

## 3. Jalankan prompt agent

Salin prompt lengkap dari samsung-setup/prompts/SETUP.id.md. Prompt singkat awal:

> Baca samsung-setup/README.id.md dan prompts/SETUP.id.md. Audit Samsung saya,
> pilih profil yang sesuai, lalu jalankan pemasangan melalui KingInstaller,
> impor preset publik dan verifikasi hasil. Pertahankan data, jangan downgrade,
> root atau uninstall. Minta bantuan saya hanya untuk dialog yang perlu disentuh.

Agent harus mencatat model, versi Android/One UI, ABI dan versi aplikasi saat ini.
Jika ada lebih dari satu koneksi ADB, agent memilih serial yang benar secara eksplisit.

## 4. Pilih profil yang sesuai

Profil s23-legacy memakai Fermata 2.0.1 + KingInstaller 2.3. Baseline ini diuji
agent pada S23 Android 16 / One UI 8.5, Android Auto 17.8, dengan video di DHU.

Profil s25-reported memakai Fermata 2.0.2 + KingInstaller 2.4. Pengguna melaporkan
berhasil pada S25 Ultra Android 17 / AA 17.9. Rincian build, One UI, metode dan fitur
belum diaudit agent. Untuk model lain, catat sebagai perangkat belum diuji.

Agent mengatur FERMATA_SETUP_PROFILE pada PowerShell yang dipakai seluruh skrip.
Tanpa pilihan eksplisit, kit tetap menggunakan profil S23 lama. Lock menentukan
URL, ukuran dan SHA256 APK. Jangan memilih pembaruan terbaru secara otomatis.

Fermata 2.0.2 menonaktifkan FS Mirror menurut upstream. Pemutaran TV/YouTube di
Fermata Auto berbeda dengan mencerminkan seluruh layar HP. Jangan menganggap
impor preset atau KingInstaller mengembalikan FS Mirror.

## 5. Pemasangan aplikasi

Agent menjalankan Get-Artifacts.ps1, Install-DesktopTools.ps1 bila diperlukan,
lalu Prepare-Phone.ps1 untuk perangkat terpilih. Berkas APK dan ZIP preset disalin
ke Download. KingInstaller dipasang dan dibuka; Fermata harus dipasang dari UI-nya.

Pilih APK sesuai profil di KingInstaller. Gunakan classic terlebih dahulu dengan
switch Root/Shizuku/Oppo mati. Berikan izin memasang aplikasi kepada KingInstaller
jika Android meminta. Jika chooser muncul, pilih Package installer dan Just once.
Tampilan pada Android yang berbeda dapat berubah; chooser tidak selalu muncul.

Tekan Install atau Update setelah memeriksa versi APK. Update dapat berarti
memasang ulang versi sama maupun naik versi; jangan menurunkan versi atau menghapus
data diam-diam. Jika tanda tangan tidak cocok, hentikan langkah pemasangan dan
laporkan pesan. Shizuku hanya dipertimbangkan jika metode biasa terbukti gagal.

## 6. Impor preferensi setelah pemasangan

Buka Fermata di HP dan selesaikan izin fitur yang diperlukan. Bila sudah mempunyai
pengaturan, ekspor preferensi sebagai backup lokal dahulu. Preset menggunakan sumber
TV ID 1; pada instalasi lama sumber tersebut dapat tertimpa. Periksa sebelum impor.

Pilih Settings > Import preferences. Pilih Download/fermata-samsung-public-v1.zip.
Jangan mengekstrak ZIP. Setelah konfirmasi impor, Fermata menutup; buka kembali.
Agent harus membedakan penyalinan ZIP dari keberhasilan impor melalui aplikasi.

Periksa Voice control aktif, bahasa Indonesia id-ID, tampilan dan sumber TV indo.
Pada Settings > Interface, pastikan Hide bars OFF dan Fullscreen OFF. Pada
Interface > Android Auto, pastikan Hide bars OFF dan Fullscreen OFF juga.
Untuk menerapkan revisi ini pada HP yang sudah diatur, impor ulang ZIP publik terbaru.
Playlist TV tetap menggunakan https://iptv-org.github.io/iptv/countries/id.m3u.
EPG XMLTV tidak disertakan karena tidak ada URL EPG pada file asal.

Preset publik berisi pengaturan tampilan/suara dan sumber TV; riwayat browser,
tontonan, favorit pribadi, cache serta metadata perangkat sudah dibuang.
Preset tidak memberikan izin mikrofon, akses akun atau pengaturan Android Auto.
ZIP bersih belum diuji impor langsung pada HP; hasilnya harus diverifikasi agent.

## 7. Uji Android Auto dan DHU

Buka pengaturan Android Auto di HP. Jika mode pengembang belum aktif, ketuk bagian
Version/Versi berulang kali, biasanya 10 kali, lalu konfirmasi pengaktifannya.
Buka menu tiga titik > Developer settings > centang Unknown sources/Sumber tidak
dikenal. Agent harus memastikan checkbox ON; jika sudah ON jangan diketuk lagi.
Jika dialog tidak dapat diakses agent, pengguna menyelesaikannya di HP lalu
memberi konfirmasi. Ini berbeda dari izin Install unknown apps milik KingInstaller.
Sambungkan ulang Android Auto bila diperlukan dan periksa Fermata di launcher.
Checkbox membantu aplikasi sideload tampil, tetapi bukan bukti bahwa semua
komponen proyeksi diterima. Bila tetap tidak muncul, periksa metode pemasangannya.

Untuk simulator, aktifkan Start head unit server di Android Auto pada HP. Agent
menjalankan Start-DHU.ps1, membuka Fermata Auto ikon play biru, memeriksa video
bergerak dan play/pause. Audio terdengar, TV, mikrofon dan pencarian suara diuji
terpisah. Hasil DHU tidak membuktikan penerimaan head unit mobil produksi.

Uji mobil saat parkir. Keyboard yang hanya muncul di posisi P mengikuti status
pembatasan Android Auto. Preset tidak membuka pembatasan kendaraan. Video dan
mirroring digunakan saat kendaraan berhenti dengan aman.

## 8. Jika ada masalah

Fermata tidak muncul: periksa versi, APK arm64, metode pemasangan dan catatan
installer; jangan langsung uninstall atau menghapus data Android Auto.

ZIP tidak terlihat: pastikan ada di Download dan pilih ZIP asli, bukan folder XML.
Jika pengaturan belum berubah, buka ulang aplikasi dan periksa hasil impor.

TV tidak berjalan: periksa koneksi dan channel lain. Playlist komunitas tidak
menjamin semua stream tersedia. EPG hanya jadwal, bukan pengganti URL siaran.

Suara gagal: periksa izin mikrofon, layanan pengenalan suara dan bahasa. Tombol
suara setir bisa membuka asisten Android Auto, bukan fitur suara Fermata.

Agent melaporkan batas akses: selesaikan dialog yang disebut di layar HP. Jangan
menganggap penolakan alat komputer sebagai bukti Samsung Auto Blocker menolak APK.

## 9. Laporan akhir dan privasi

Agent melaporkan profil, versi, metode, tiga field installer, hasil impor,
keberadaan TV indo dan hasil tiap pengujian. Tandai belum diuji bila tanpa bukti.
Jangan mengunggah backup pribadi, logcat mentah, serial, IP, token atau screenshot
yang memperlihatkan akun dan alamat. Checksum bukan sertifikat bebas malware.
Cabut izin Install unknown apps KingInstaller dan matikan debugging saat selesai
jika tidak lagi diperlukan. Simpan backup dan profil yang berhasil.

## 10. Prompt lanjutan dan referensi

Prompt per tahap: samsung-setup/prompts/STEPS.id.md. Untuk melanjutkan sesi:
samsung-setup/prompts/RESUME.id.md. Rincian preset: preferences/README.id.md.

Referensi: [repo Samsung](https://github.com/freycawproject/fermata-s23-working),
[Fermata 2.0.2](https://github.com/AndreyPavlenko/Fermata/releases/tag/2.0.2),
[KingInstaller 2.4](https://github.com/fcaronte/KingInstaller/releases/tag/2.4),
[Google DHU](https://developer.android.com/training/cars/testing/dhu),
[Developer mode dan Unknown sources](https://developer.android.com/training/cars/testing),
serta [playlist IPTV-org](https://github.com/iptv-org/iptv).
