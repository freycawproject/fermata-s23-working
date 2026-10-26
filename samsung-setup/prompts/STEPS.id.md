# Prompt per tahap

Gunakan setelah agent membaca README. Salin satu blok setiap kali ingin
menjalankan tahap tertentu. Tahap lanjutan tetap harus memeriksa hasil tahap sebelumnya.

## 1. Audit dan pemilihan profil

```text
Baca samsung-setup/README.id.md dan docs/COMPATIBILITY.id.md. Audit HP Samsung
melalui koneksi ADB aktif: model, Android/One UI, ABI, AA, Fermata, KingInstaller.
Jangan mengubah HP dahulu. Pilih s23-legacy atau s25-reported dengan alasan;
jangan downgrade versi terpasang. Simpan laporan lokal tanpa identitas pribadi.
```

## 2. Persiapan berkas

```text
Gunakan hasil audit. Tetapkan FERMATA_SETUP_PROFILE pada proses PowerShell yang
akan menjalankan skrip. Jalankan Get-Artifacts.ps1 dan verifikasi ukuran/SHA256,
termasuk preferences/preset.lock.json. Siapkan alat desktop bila dibutuhkan.
Jangan gunakan APK latest atau cadangan preferensi pribadi. Laporkan profil/versi.
```

## 3. Pemasangan KingInstaller dan Fermata

```text
Baca docs/INSTALL.id.md. Audit ulang koneksi dan aplikasi. Jika pemasangan perlu,
jalankan Prepare-Phone.ps1 dengan serial aktif. Pasang Fermata dari UI KingInstaller
classic, switch tambahan OFF. Periksa layar saat ini, jangan pakai koordinat lama.
Jangan memasang Fermata lewat adb install, downgrade, uninstall atau hapus data.
Jika sudah berfungsi jangan reinstall. Laporkan versi dan tiga field installer.
```

## 4. Impor preferensi publik

```text
Baca preferences/README.id.md. Backup preferensi pengguna yang sudah ada ke lokal.
Periksa apakah sumber TV ID 1 sudah digunakan sebelum impor karena dapat tertimpa.
Impor Download/fermata-samsung-public-v1.zip dari Settings > Import preferences
Fermata pada HP. Jangan ekstrak ZIP dan jangan mengklaim adb push sebagai impor.
Minta pengguna menangani picker bila alat tidak dapat mengaksesnya. Setelah Fermata
menutup, buka lagi. Verifikasi suara id-ID dan playlist TV indo. Di Settings >
Interface, Hide bars dan Fullscreen harus OFF; di Interface > Android Auto,
Hide bars dan Fullscreen juga harus OFF. Gunakan ZIP publik terbaru.
```

## 5. Uji dan laporan

```text
Buka Settings Android Auto di HP. Aktifkan mode pengembang melalui bagian Versi
(ketuk berulang kali, biasanya 10 kali, lalu konfirmasi). Buka menu tiga titik >
Developer settings > centang Unknown sources/Sumber tidak dikenal dan pastikan ON.
Jika sudah ON jangan dimatikan. Ini berbeda dari izin Install unknown apps Android.
Jika agent tidak bisa mengakses checkbox, minta bantuan pengguna dan verifikasi hasil.
Periksa launcher setelah menyambung ulang bila perlu; jangan menjamin checkbox saja
cukup untuk penerimaan proyeksi. Buka Android Auto > Customize launcher/Sesuaikan
peluncur. Dari tiga entri Fermata, centang hanya Fermata Auto (ikon play biru) dan
uncheck dua entri Fermata lainnya sesuai nama yang benar di UI. Jangan mengubah
pilihan aplikasi lain, uninstall atau menonaktifkan service. Jika jumlah entri
berbeda, gunakan entri yang tersedia; jangan mengarangnya. Sambungkan ulang dan
pastikan dari keluarga Fermata hanya Fermata Auto terlihat. Minta bantuan pengguna
jika UI tidak terjangkau agent. Uji DHU jika tersedia dan pisahkan hasil mobil
saat parkir. Verifikasi
video bergerak, play/pause, audio, satu channel TV, keyboard saat P, dan suara.
Jangan membuka pembatasan kendaraan. Bedakan laporan pengguna dan pengamatan agent.
Fermata 2.0.2 menonaktifkan FS Mirror menurut upstream. Tandai fitur yang tidak
diuji sebagai BELUM DIUJI. Jangan unggah bukti pribadi atau membuat klaim semua Samsung.
```
