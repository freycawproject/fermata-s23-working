# Fermata Samsung: pemasangan melalui agent

Mulai dengan **[prompt lengkap](prompts/SETUP.id.md)** pada agent yang memiliki akses
terminal Windows, filesystem, dan ADB. Untuk sesi bertahap gunakan
**[prompt per tahap](prompts/STEPS.id.md)**. Pengguna tetap menyelesaikan dialog izin
Android atau tindakan di layar bila otomasi tidak dapat mengaksesnya.

Panduan yang dapat dibagikan: **[PDF instalasi melalui agent](docs/INSTALASI-AGENT.id.pdf)**
dan [sumber panduan](docs/INSTALASI-AGENT.id.md).

## Pilih profil sebelum menjalankan skrip

| Profil | APK | Bukti |
|---|---|---|
| `s23-legacy` | Fermata 2.0.1 arm64 + KingInstaller 2.3 | Pengujian agent di S23, Android 16 / One UI 8.5, AA 17.8; video di DHU |
| `s25-reported` | Fermata 2.0.2 arm64 + KingInstaller 2.4 | Pengguna melaporkan berhasil di S25 Ultra, Android 17, AA 17.9; build lengkap dan One UI belum dicatat |
| Samsung lainnya | Pilih berdasarkan versi terpasang dan kebutuhan fitur | Belum diuji; tidak ada jaminan semua model/patch kompatibel |

Profil dipilih secara eksplisit dalam PowerShell dari folder `samsung-setup`:

```powershell
$env:FERMATA_SETUP_PROFILE = 's25-reported'
.\scripts\Get-Artifacts.ps1
.\scripts\Install-DesktopTools.ps1
.\scripts\Prepare-Phone.ps1 -Serial '<serial aktif>'
```

Untuk profil lama pilih `s23-legacy`. Tanpa variabel, skrip tetap memakai profil
S23 lama agar perilaku kit terdahulu tidak berubah. Semua skrip dalam proses itu
memakai profil yang sama. Skrip Prepare menyalin APK dan preset, memasang
KingInstaller, lalu membukanya; Fermata dipasang lewat UI KingInstaller.

Jika PowerShell memblokir skrip lokal, gunakan proses khusus
`powershell.exe -NoProfile -ExecutionPolicy RemoteSigned`; tidak mengubah kebijakan
mesin. Ikuti Group Policy organisasi. Tidak perlu mengubah registry.

## Setelah pemasangan: impor preset publik

Agent menyalin **[fermata-samsung-public-v1.zip](preferences/fermata-samsung-public-v1.zip)**
ke Download. Buka Fermata di HP, selesaikan izin, ekspor backup bila sudah ada
pengaturan, lalu pilih Settings > Import preferences dan ZIP tersebut.
Jangan ekstrak ZIP. Setelah impor aplikasi menutup; buka kembali dan verifikasi.
Penyalinan ADB saja tidak melakukan impor.

Preset mempertahankan suara Indonesia, tampilan, dan **URL playlist TV asli**.
Riwayat browser/tontonan, favorit, cache dan metadata perangkat dibuang.
Lihat [rincian preset](preferences/README.id.md). Preset bersih belum diuji impor
langsung ke HP; agent harus menguji sebelum menyebut setup selesai.

## Batas dan fitur

- Fermata 2.0.2 menonaktifkan FS Mirror menurut catatan rilis resmi. Keberhasilan
  Fermata Auto/YouTube/TV tidak membuktikan pencerminan seluruh layar HP.
- Source aplikasi di branch ini tetap tag 2.0.1; profil baru menggunakan APK resmi
  2.0.2 terpisah. Kode aplikasi upstream tidak diubah oleh kit.
- Shizuku adalah cadangan, bukan syarat pemasangan normal. Root tidak termasuk.
- Keyboard yang muncul saat gigi P mengikuti status pembatasan Android Auto.
  Preset tidak membuka pembatasan saat kendaraan bergerak.
- DHU adalah pengujian pengembang; penerimaan head unit mobil diuji terpisah saat
  parkir. Suara/mikrofon, tiap channel TV, dan FS Mirror membutuhkan bukti sendiri.
- Checksum membuktikan kesamaan berkas, bukan jaminan bebas malware.

Lihat [instalasi teknis](docs/INSTALL.id.md), [kompatibilitas](docs/COMPATIBILITY.id.md),
[bukti S23 lama](docs/VERIFIED.id.md), dan [validasi pembaruan](docs/UPDATE-VALIDATION.id.md).

## Unduhan dan source

`Get-Artifacts.ps1` memeriksa ukuran dan SHA256 sesuai lock profil. Tambahkan
`-IncludeOptional` untuk Shizuku, `-IncludeSources` untuk arsip source, atau
`-VerifyOnly` untuk memeriksa berkas lokal tanpa unduhan.
APK/arsip Google tidak ditambahkan ke Git. Unduh dari pengembang melalui skrip;
ketentuan dan lisensi masing-masing tetap berlaku. Release lama tetap tersedia
sebagai rekaman konfigurasi lama dan tidak otomatis berisi profil baru.

Sumber resmi: [Fermata 2.0.2](https://github.com/AndreyPavlenko/Fermata/releases/tag/2.0.2),
[KingInstaller 2.4](https://github.com/fcaronte/KingInstaller/releases/tag/2.4),
[Google DHU](https://developer.android.com/training/cars/testing/dhu).
