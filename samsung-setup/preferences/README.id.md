# Preset publik Samsung v1

Unduh `fermata-samsung-public-v1.zip`, bukan folder XML satu per satu. ZIP berisi
tiga XML SharedPreferences Android. `preset.lock.json` mencatat SHA256, ukuran,
dan allowlist kunci. `py build_preset.py` membangun ulang ZIP secara deterministik
dari XML publik di folder ini, tanpa membaca cadangan pribadi.

## Dipertahankan

- `fermata.xml`: 9 kunci tampilan dan suara. Voice control aktif, `id-ID`, aktivasi
  melalui tombol mengambang dan tema dari cadangan. Sesuai revisi pemilik,
  Interface > Hide bars dan Fullscreen **OFF**; Interface > Android Auto >
  Hide bars dan Fullscreen juga **OFF**. Empat kunci yang diubah adalah
  HIDE_BARS, FULLSCREEN, HIDE_BARS_AA dan FULLSCREEN_AA, semuanya false.
- `tvm3u.xml`: nama sumber `indo`, URL playlist TV asli, tipe video, interval refresh,
  dan counter ID. URL publiknya `https://iptv-org.github.io/iptv/countries/id.m3u`.
- `medialib.xml`: tiga kunci penghubung sumber TV ke playlist. Tanpa ini URL saja
  belum tentu muncul sebagai sumber TV yang terdaftar.

URL TV dipertahankan sesuai permintaan pemilik. Tidak terdapat query/token atau
userinfo pada URL tersebut. Berkas asal tidak memuat EPG XMLTV URL; preset tidak
mengarang URL jadwal. Ketersediaan setiap stream perlu diuji terpisah.

## Dibuang

Riwayat tontonan dan item terakhir, favorit pribadi, alamat browser terakhir,
riwayat origin WebView, flag/cache WebView, ID internal ActivityThread,
timestamp/ETag playlist, metadata migrasi versi, dan pengaturan navigasi khusus
sesi. Pilihan mematikan pengecekan update dari cadangan asli tidak dibawa;
kit tetap menentukan versi melalui lock, tanpa memperbarui aplikasi otomatis.
Pilihan decoder media juga tidak dipaksakan lintas model.

## Cara impor oleh agent dan pengguna

1. Sebelum mengubah perangkat yang sudah dipakai, ekspor preferensi lama dan
   simpan backup lokal. Jangan unggah backup pribadi ke GitHub.
2. Agent menyalin ZIP publik ke Download melalui Prepare-Phone.ps1.
3. Di Fermata pada HP pilih Settings > Import preferences > ZIP publik.
4. Konfirmasikan hasil impor; aplikasi akan menutup. Buka ulang, bukan instal ulang.
5. Periksa Voice control, bahasa Indonesia, empat opsi tampilan OFF di atas,
   dan sumber TV `indo`. Impor ulang ZIP terbaru untuk menerapkan revisi ini.
6. Uji mikrofon dengan izin Android yang relevan dan coba satu siaran TV saat parkir.

Implementasi import pada source 2.0.1 menggabungkan nilai kunci dari berkas yang
diimpor, bukan menghapus seluruh preferensi. Karena itu, di instalasi lama,
kunci yang tidak ada dalam preset dapat tetap tersimpan. Mengimpor preset bersih
tidak membersihkan riwayat yang sudah berada di HP. Perilaku runtime 2.0.2 tetap
perlu diverifikasi. ZIP bersih belum diuji impor langsung pada HP.

Preset tidak berisi izin Android, akses Shizuku, akun, kata sandi, atau pengaturan
Android Auto; semua itu tidak dapat diberikan hanya dengan impor ZIP.
Untuk ikon, agent/pengguna harus membuka Android Auto > Customize launcher dan
mencentang hanya Fermata Auto dari tiga entri Fermata, lalu uncheck dua lainnya.
Pilihan aplikasi lain tidak diubah. Sambungkan ulang untuk memeriksa hasilnya.
