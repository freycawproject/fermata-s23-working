# Referensi teknis untuk agent

Panduan utama: [PDF](INSTALASI-AGENT.id.pdf), [sumber panduan](INSTALASI-AGENT.id.md),
[prompt lengkap](../prompts/SETUP.id.md), [prompt tahap](../prompts/STEPS.id.md).

1. Baca README dan kompatibilitas. Audit perangkat yang benar: model, Android,
   One UI, ABI, versi AA, Fermata dan KingInstaller. Jangan mematok serial/IP lama.
2. Pilih `FERMATA_SETUP_PROFILE`: `s23-legacy` atau `s25-reported`. Pilihan ini
   berlaku pada semua skrip yang dijalankan dalam proses PowerShell tersebut.
3. Jalankan Get-Artifacts.ps1, lalu Install-DesktopTools.ps1 bila alat belum ada.
   Gunakan -IncludeOptional hanya bila perlu. Periksa ukuran dan checksum.
4. Jalankan Verify-Phone.ps1. Jika instalasi berfungsi, jangan memasang ulang
   hanya demi menyamakan metadata. Jangan downgrade versi yang lebih baru.
5. Bila pemasangan diperlukan, jalankan Prepare-Phone.ps1 -Serial '<serial>'.
   Skrip memasang KingInstaller, menyalin APK Fermata dan preset, lalu membuka
   KingInstaller; skrip tidak menginstal Fermata lewat shell.
6. Gunakan classic terlebih dahulu, Root/Shizuku/Oppo OFF. Pilih APK sesuai profil.
   Jika ada pemilih installer, gunakan Package installer > Just once; UI dapat
   berbeda antar Android. Jangan menganggap chooser selalu muncul di Android 15+.
7. Konfirmasikan Install atau Update. Update bisa berarti pemasangan ulang versi
   sama atau peningkatan ke versi yang dipilih; selalu periksa nama/versi APK.
   Jangan uninstall, hapus data atau downgrade otomatis.
8. Buka Fermata di HP dan selesaikan izin fitur yang relevan. Untuk instalasi lama,
   ekspor backup preferensi. Pilih Settings > Import preferences >
   Download/fermata-samsung-public-v1.zip. Jangan ekstrak; impor menutup aplikasi.
9. Buka ulang. Periksa suara id-ID dan playlist TV indo. Pastikan Hide bars OFF
   dan Fullscreen OFF pada Interface maupun Interface > Android Auto. Jangan menyatakan
   impor sukses hanya karena adb push berhasil. Jika UI tidak dapat diakses,
   minta pengguna melakukan langkah layar yang spesifik dan tunggu hasilnya.
10. Audit ulang installer, service dan runtime. Pola S23 yang diamati:
    installerPackageName=com.android.vending,
    initiatingPackageName=com.google.android.packageinstaller,
    originatingPackageName=com.example.kinginstaller.
    Ini referensi S23, bukan syarat universal terbukti untuk S25/semua Samsung.
11. Di Settings Android Auto pada HP, aktifkan Developer mode melalui bagian Versi
    bila belum aktif (ketuk berulang kali, biasanya 10 kali, lalu konfirmasi).
    Buka menu tiga titik > Developer settings > centang Unknown sources dan
    verifikasi ON. Jangan mengetuk checkbox yang sudah ON. Ini bukan izin Install
    unknown apps Android. Jika alat tidak bisa mengaksesnya, minta pengguna
    menyelesaikan dialog lalu konfirmasi. Periksa launcher setelah reconnect bila
    perlu; checkbox bukan jaminan penerimaan komponen proyeksi.
    Buka Customize launcher/Sesuaikan peluncur. Dari tiga entri Fermata, centang
    hanya Fermata Auto (ikon play biru), lalu hapus centang dua entri Fermata
    lainnya sesuai nama di layar. Nama/jumlah dapat berbeda antar versi.
    Jangan mengubah pilihan aplikasi lain atau menonaktifkan paket/service.
    Sambungkan ulang Android Auto dan verifikasi hanya Fermata Auto yang muncul
    dari keluarga Fermata. Minta bantuan pengguna jika UI tidak terjangkau agent.
    Untuk DHU,
    aktifkan Start head unit server di HP dan jalankan Start-DHU.ps1.
    Uji gambar bergerak, play/pause, suara secara terpisah, TV dan input saat parkir.
12. Jika classic gagal, simpan bukti ringkas dan pertimbangkan Shizuku sebagai
    cadangan. Jangan root atau menghapus aplikasi tanpa otorisasi khusus.

## DeX dan multi-display

Periksa display, paket activity, bounds dan screenshot saat ini sebelum mengetuk.
Jangan menggunakan XML lama setelah dump gagal, ID display lama atau bounds nol.
Jika alat menolak perintah sebelum sampai ke HP, jangan menyebutnya Auto Blocker.

## Batas pengujian

DHU tidak membuktikan penerimaan head unit mobil produksi. FS Mirror dinonaktifkan
di 2.0.2 menurut upstream; jangan menyamakan video Fermata dengan mirroring HP.
Pembatasan keyboard di luar posisi P bukan masalah yang diperbaiki preset.
Uji mobil ketika parkir. Simpan bukti lokal; jangan unggah screenshot pribadi.
