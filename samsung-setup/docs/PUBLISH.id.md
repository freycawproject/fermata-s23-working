# Publikasi fork di GitHub

Source ini mempertahankan riwayat upstream dan menambahkan branch
`samsung-s23-working` dari tag 2.0.1. Remote lokal `upstream` menunjuk repo asli.
Tidak ada credential GitHub yang disimpan di paket ini.

Setelah akun GitHub terhubung, buat fork **AndreyPavlenko/Fermata** ke akun atau
organisasi tujuan. Gunakan nama seperti `fermata-s23-working`. Jangan membuat
repo kosong lalu menyebutnya sebagai fork GitHub.

Jika memakai GitHub CLI yang sudah login:

```powershell
gh repo fork AndreyPavlenko/Fermata --fork-name fermata-s23-working --clone=false
git remote add origin https://github.com/AKUN/fermata-s23-working.git
git push -u origin samsung-s23-working
git push origin setup-s23-2026-10-24
```

Ganti `AKUN` dengan akun yang terotorisasi. Jangan menjalankan contoh placeholder
apa adanya. Bila CLI tidak tersedia, buat fork lewat GitHub atau integrasi GitHub,
kemudian tambah remote dan push branch yang sama. Branch default fork boleh tetap
milik upstream; buka branch `samsung-s23-working` untuk melihat kit ini.

## Memulihkan Git bundle

Paket lokal menyertakan `fermata-s23-working.git.bundle`:

```powershell
git clone fermata-s23-working.git.bundle fermata-restored
Set-Location fermata-restored
git switch samsung-s23-working
git remote rename origin bundle
git remote add upstream https://github.com/AndreyPavlenko/Fermata.git
```

APK Fermata lebih dari 100 MB. Binary tidak dimasukkan sebagai file Git biasa.
Repo memakai URL rilis resmi dan checksum; ZIP offline lokal menyertakan binary
agar pemilik paket dapat memasang ulang. Jangan otomatis memublikasikan ZIP itu
sebagai release tanpa memeriksa lisensi/notices setiap komponen, khususnya alat
Google. Tidak diperlukan binary Google di repo untuk menjalankan skrip downloader.

## Yang tidak boleh dipublikasikan

Logcat penuh, dump paket mentah, IP/serial HP, screenshot berisi email atau
notifikasi, credential, backup preferensi pengguna, dan APK hasil patch yang
tidak jelas asalnya. Direktori reports/exports/artifacts diabaikan Git.
