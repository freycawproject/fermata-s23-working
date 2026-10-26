# Prompt pemasangan melalui agent

Salin blok ini ke agent yang memiliki terminal Windows, akses berkas dan ADB.
Selesaikan pairing Wireless debugging bila agent tidak bisa mengakses dialog HP.

```text
Bertindak sebagai Android QA & Automation Engineer. Saya mengizinkan pemasangan
dan konfigurasi Fermata melalui kit samsung-setup dalam repo ini. Kerjakan
tindakan rutin sampai hasil bisa diverifikasi. Pengguna membantu dialog HP yang
tidak dapat dijangkau alat. Jangan mengklaim langkah layar sudah selesai tanpa bukti.

BACA: samsung-setup/README.id.md, docs/COMPATIBILITY.id.md, docs/INSTALL.id.md,
preferences/README.id.md, versions.lock.json dan profiles/s25-reported.lock.json.
PDF docs/INSTALASI-AGENT.id.pdf adalah panduan pengguna. Prompt per tahap ada di
prompts/STEPS.id.md. Kode aplikasi branch masih 2.0.1; APK profil baru resmi 2.0.2.

PROFIL:
- s23-legacy: Fermata 2.0.1 + KingInstaller 2.3, baseline S23 Android16/OneUI8.5.
- s25-reported: Fermata 2.0.2 + KingInstaller 2.4, dilaporkan pengguna berhasil pada
  S25 Ultra Android17/AA17.9, belum diverifikasi agent. FS Mirror dinonaktifkan 2.0.2.
- Samsung lain belum diuji. Audit ABI (kit arm64), versi terpasang, kebutuhan fitur
  dan pilih profil dengan alasan. Jangan menjanjikan semua Samsung kompatibel.

LANGKAH:
1. Temukan ADB dan koneksi aktif, targetkan serial eksplisit serta profil utama
   user 0. Catat model, Android/OneUI/ABI dan versi lengkap aplikasi. Jangan
   membaca akun, galeri, email, Secure Folder atau file pribadi di luar kebutuhan.
2. Pada proses PowerShell yang dipakai semua skrip, atur
   $env:FERMATA_SETUP_PROFILE = 's25-reported' atau 's23-legacy' sesuai keputusan.
   Default tanpa variabel tetap profil lama. Jangan memilih versi latest otomatis.
3. Get-Artifacts.ps1 memeriksa ukuran/SHA256. Install-DesktopTools.ps1 menyiapkan
   alat bila belum ada. Verify-Phone.ps1 mengaudit instalasi. Jika sudah berfungsi,
   pertahankan. Jangan memakai adb install/pm install -i untuk memasang Fermata.
4. Bila diperlukan, Prepare-Phone.ps1 -Serial '<serial>' memasang KingInstaller,
   menyalin APK profil dan ZIP preset ke Download. Gunakan UI KingInstaller,
   classic dahulu, switch Root/Shizuku/Oppo OFF. Chooser Package installer bila
   muncul > Just once > Install/Update APK yang dipilih. Jangan downgrade,
   uninstall, clear data, root, unlock bootloader atau mengganti signing.
5. Periksa UI/display dan bounds terbaru, terutama DeX. Jangan menggunakan dump
   lama setelah kegagalan. Jika akses alat terbatas, minta bantuan pengguna untuk
   langkah tertentu tanpa mengarang hasil. Bedakan penolakan alat dan Auto Blocker.
6. Setelah pemasangan buka Fermata di HP, berikan izin yang relevan. Ekspor backup
   preferensi lama, simpan lokal. Import preferences menggunakan ZIP PUBLIK
   Download/fermata-samsung-public-v1.zip, bukan cadangan pribadi pemilik repo.
   Jangan ekstrak ZIP. Setelah aplikasi menutup, buka kembali. Penyalinan bukan impor.
7. Verifikasi Voice control aktif, bahasa id-ID dan TV indo. Di Settings > Interface,
   pastikan Hide bars OFF dan Fullscreen OFF; di Interface > Android Auto, pastikan
   Hide bars OFF dan Fullscreen OFF juga. Impor ulang ZIP publik terbaru bila perlu.
   URL TV
   dipertahankan di preset. Jangan menghapus playlist pengguna lain; jika sumber ID
   1 sudah dipakai, jelaskan potensi tertimpa dan simpan backup sebelum impor.
8. Audit versi dan tiga field installer. Bandingkan pola S23 sebagai referensi,
   bukan bukti universal. Jika berfungsi, jangan lanjut Shizuku. Jika classic gagal,
   kumpulkan bukti terbatas lalu pertimbangkan Shizuku; root di luar lingkup.
9. Buka pengaturan Android Auto di HP. Jika mode pengembang belum aktif, ketuk
   bagian Version/Versi berulang kali (biasanya 10 kali) dan konfirmasi dialognya.
   Buka menu tiga titik > Developer settings > centang Unknown sources/Sumber
   tidak dikenal. Baca keadaan checkbox dan pastikan ON, jangan sekadar membukanya.
   Jika sudah ON jangan mengetuk hingga OFF. Jika agent tidak bisa mengaksesnya,
   minta pengguna melakukan langkah ini lalu konfirmasi hasil. Izin Install unknown
   apps milik KingInstaller berbeda dari Unknown sources di Android Auto.
   Periksa launcher Android Auto setelah menyambung ulang bila diperlukan;
   checkbox ini membantu aplikasi sideload tampil tetapi bukan jaminan penerimaan
   semua komponen proyeksi. Jika Fermata belum muncul, lanjutkan diagnosis installer.
   Buka Android Auto > Customize launcher/Sesuaikan peluncur. Dari tiga entri
   Fermata yang muncul setelah pemasangan, centang hanya Fermata Auto (ikon play
   biru); hapus centang dua entri Fermata lainnya. Cocokkan nama di UI saat ini:
   misalnya Fermata Media Service, Fermata Mirror atau FS Fermata Mirror, tergantung
   versi. Jangan mengubah checkbox aplikasi lain seperti Maps/Telepon. Jika hanya
   satu entri Fermata tersedia, jangan mengarang entri yang tidak ada. Sembunyikan
   lewat checkbox launcher, bukan uninstall atau menonaktifkan service/paket.
   Sambungkan ulang Android Auto dan verifikasi hanya Fermata Auto yang terlihat
   dari keluarga Fermata. Jika agent tidak dapat mengakses UI, minta pengguna
   menyelesaikan langkah ini dan konfirmasi hasilnya.
   Uji DHU terlihat jika tersedia, melalui Start head unit server lalu Start-DHU.ps1.
   Buka Fermata Auto ikon play biru, uji video dengan adegan berubah dan play/pause.
   Uji audio terdengar, TV dan suara masing-masing; jangan mengasumsikan hasilnya.
10. Mobil diuji terpisah saat parkir. Keyboard di posisi P dan pembatasan Android
    Auto tetap berlaku; jangan memodifikasi sensor kendaraan/pembatasan keselamatan.

LAPORAN: versi, profil, metode, tiga field installer, status impor preset, URL TV
terdaftar, DHU, mobil, YouTube/TV/audio/keyboard/suara/FS Mirror. Gunakan BERHASIL,
GAGAL atau BELUM DIUJI disertai bukti. Jangan menyatakan FS Mirror 2.0.2 bekerja
tanpa bukti tersendiri. Jangan mengunggah logcat, backup, token, serial atau
screenshot pribadi. Jangan memublikasikan apa pun di akun pengguna tanpa instruksi.
Lanjutkan pekerjaan rutin yang sudah diizinkan; minta bantuan hanya pada batas nyata.
```
