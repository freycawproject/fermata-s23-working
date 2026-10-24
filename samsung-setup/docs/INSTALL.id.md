# Instalasi melalui KingInstaller

1. Aktifkan Developer options dan Wireless debugging pada HP. Pair laptop bila
   diperlukan; gunakan port koneksi yang tampil saat ini. Skrip selalu menargetkan
   serial eksplisit atau satu-satunya perangkat terotorisasi, profil utama user 0.
2. Jalankan `Get-Artifacts.ps1`, `Install-DesktopTools.ps1`, lalu `Prepare-Phone.ps1`.
   Versi berbeda yang sudah terpasang tidak dihapus otomatis. Jika versinya lebih
   baru dari 2.0.1, berhenti dan rencanakan backup; jangan uninstall atau downgrade
   tanpa persetujuan pengguna.
3. Buka KingInstaller 2.3. Izinkan akses file dan izin memasang aplikasi dari
   sumber KingInstaller saat Android meminta. Auto Blocker Samsung dan pembatasan
   alat agen di laptop adalah dua hal berbeda.
4. Pilih `Download/fermata-auto-2.0.1-arm64.apk`.
5. Biarkan pilihan **Oppo/Realme/OnePlus, Root, dan Shizuku OFF**. Tap
   **Install as king**.
6. Bila muncul pemilih aplikasi, pilih **Package installer**, kemudian **Just
   once**. Jangan memilih KingInstaller lagi atau Install with Options.
7. Konfirmasikan Install atau **Update**. Kata Update di sini juga digunakan
   Android untuk memasang ulang APK versi yang sama; bukan berarti mengunduh versi
   Fermata terbaru. Tunggu sampai selesai.
8. Jalankan `Verify-Phone.ps1 -Launch`. Bandingkan tiga field installer dengan
   baseline di README. `installer=com.android.vending` saja belum cukup.
9. Buka Fermata di HP dan selesaikan izin media yang diperlukan. Izin overlay
   dipakai fitur tertentu; aktifkan bila diminta untuk fitur yang diuji. Jangan
   mengaktifkan semua izin yang tidak relevan secara membabi buta.
10. Aktifkan Developer mode Android Auto bila belum aktif. Unknown sources berguna
    untuk Media Service, tetapi bukan bukti bahwa komponen proyeksi diizinkan.
    Aktifkan **Start head unit server**, jalankan DHU, lalu pilih **Fermata Auto**.

## Samsung DeX / multi-display

Saat memakai otomasi ADB, aplikasi mungkin ada di display DeX, bukan display 0.
Periksa display ID dan activity yang benar sebelum setiap ketukan. ID display
berubah; jangan mematok angka dari sesi sebelumnya. XML UI yang gagal atau
`null root node` tidak boleh digantikan XML lama. Buat nama dump baru setiap kali,
pastikan nama paket dan bounds terlihat, lalu cocokkan screenshot display terkait
bila perlu. Hindari mengetuk `[0,0][0,0]` atau mengira layar HP sama dengan DeX.

## Bila audit belum cocok

- Coba metode Shizuku hanya setelah mengamati kegagalan metode biasa.
- Jangan langsung menghapus data Android Auto atau uninstall Fermata. Ekspor
  preferensi terlebih dahulu bila tindakan itu memang diperlukan dan disetujui.
- Tidak ada jaminan satu installer bekerja pada semua patch Samsung.
- Bila service proyeksi tidak muncul, bedakan masalah validasi dari decoder/video
  hitam. Kumpulkan bukti dengan filter paket, bukan semua isi HP.
- Jika simulator terputus, periksa crash Android Auto sendiri. Pada sesi awal DHU
  2.0 terjadi crash `ViewTreeLifecycleOwner not found`; sesi berikutnya dengan DHU
  2.1 berhasil. Urutan itu tidak membuktikan penyebab tunggal.
