# Kompatibilitas dan tingkat bukti

| Perangkat | Sistem | APK | Bukti / batas |
|---|---|---|---|
| Galaxy S23 SM-S911B | Android 16, One UI 8.5; AA 17.8.663874 saat setup | Fermata 2.0.1, KingInstaller 2.3 classic | Agent mengamati video dan play/pause di DHU. Pengguna kemudian menyatakan berjalan. FS Mirror belum diuji tersendiri. |
| Galaxy S23 | AA 17.9.664044 saat tes keyboard | Fermata 2.0.1 | Keyboard pencarian YouTube berhasil di DHU; browser sempat gagal. Pengguna mengonfirmasi keyboard muncul di posisi P. |
| Galaxy S25 Ultra | Android 17 dan AA 17.9 menurut pengguna; One UI/build/patch belum diberikan | Fermata 2.0.2, KingInstaller 2.4 | Pengguna melaporkan semua berjalan. Metode/switch KingInstaller, tiga field installer, fitur rinci dan impor preset bersih belum diverifikasi agent. |
| Samsung lain | Belum diuji | Belum ditetapkan | Jangan menyalin hasil S23/S25 sebagai bukti perangkat lain. APK kit saat ini arm64 saja. |

Target kit ialah membantu pemasangan pada berbagai Samsung, bukan menjamin
semua Samsung kompatibel. Perbedaan ABI, patch sistem, Android Auto, installer
dan head unit dapat mengubah hasil.

## Format laporan kontribusi

Catat model, Android, One UI, patch keamanan, versi lengkap AA/Fermata/KingInstaller,
metode classic atau Shizuku, tiga field installer, dan koneksi kabel/wireless.
Tandai setiap hasil sebagai berhasil, gagal atau belum diuji: muncul di launcher,
YouTube/video, audio, TV, browser, keyboard saat P, suara, FS Mirror, DHU dan mobil.
Tuliskan apakah preset publik diimpor dan apakah sumber TV muncul setelahnya.
Jangan sertakan serial, IP, akun, alamat rumah, token, riwayat atau logcat mentah.
