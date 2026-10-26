## Fermata Samsung: pemasangan melalui agent

Kit mendukung profil S23 **Fermata 2.0.1 + KingInstaller 2.3** yang diuji di DHU,
dan profil S25 Ultra **2.0.2 + 2.4** berdasarkan laporan pengguna.
Model Samsung lain belum dijamin kompatibel. Source aplikasi tetap 2.0.1;
profil baru mengunduh APK resmi upstream 2.0.2, bukan hasil build branch ini.

- [Mulai dan pilih profil](samsung-setup/README.id.md)
- [Unduh paket rilis Latest](https://github.com/freycawproject/fermata-s23-working/releases/latest)
- [PDF panduan instalasi melalui agent](samsung-setup/docs/INSTALASI-AGENT.id.pdf)
- [Prompt lengkap](samsung-setup/prompts/SETUP.id.md) dan [prompt per tahap](samsung-setup/prompts/STEPS.id.md)
- [Preset publik dengan URL TV](samsung-setup/preferences/README.id.md)
- [Kompatibilitas dan batas bukti](samsung-setup/docs/COMPATIBILITY.id.md)

Fermata 2.0.2 menonaktifkan FS Mirror menurut upstream. Preset tidak membuka
pembatasan keyboard kendaraan. Backup dan bukti pribadi tidak dimasukkan ke Git.

---

## !!!Be aware of scam!!! The sites like https://fermata-auto.com/ are 100% scam. This app is free and opensource!


## Fermata Media Player
[<img alt="Get it on Google Play" height="60" src="https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png">](https://play.google.com/store/apps/details?id=me.aap.fermata)

## About
Fermata Media Player is a free, open source audio, video and TV player with a simple and intuitive interface. It is focused on playing media files organized in folders and playlists.

Supported features:

* Play media files organized in folders
* IPTV addon with support for XMLTV EPG and Catchup
* Remembers the last played track and position for each folder
* Support for favorites and playlists
* Support for CUE and M3U playlists
* Support for bookmarks
* Audio effects: Equalizer, Bass/Volume Boost and Virtualizer
* Configure audio effects for individual tracks and folders
* Configure playback speed for individual tracks and folders
* Customizable titles and subtitles
* Support for Android Auto
* Support for Android TV
* Show favorites and playlists on Android TV home screen
* Pluggable media engines: MediaPlayer, ExoPlayer and VLC
* Video player with support for subtitles and audio streams (VLC Engine only)

## Building the project
* Download and install the latest Android SDK or Android Studio from https://developer.android.com/studio/
* Set the environment variable ANDROID_SDK_ROOT pointing to the SDK directory
```bash
export ANDROID_SDK_ROOT=<path to android SDK>
```

### Clone the repository
```bash
git clone --recurse-submodules https://github.com/AndreyPavlenko/Fermata.git
cd Fermata
```

### Build AAB
```bash
./gradlew bundleAutoRelease -PAPP_ID_SFX=.type.your.pkg.sfx.here
find $PWD -name *.aab
```

### Build APK
```bash
./gradlew bundleAutoRelease -PAPP_ID_SFX=.type.your.pkg.sfx.here
find $PWD -name *.apk
```

### Building in docker
```bash
docker run -ti --name Fermata andreypavlenko/fermata
```
Enter the requested key alias and password, when prompted.
Build the required package using the above commands.
To copy the built package to the host machine, open a new terminal and run:
```bash
docker cp Fermata:/home/mobiledevops/Fermata/fermata/build/outputs/bundle/autoRelease/ .
```


## Donation
If you like the application, please consider making a donation:

[PayPal](https://www.paypal.com/donate/?hosted_button_id=NP5Q3YDSCJ98N)

[CloudTips](https://pay.cloudtips.ru/p/a03a73da)

[Yandex Money](https://money.yandex.ru/to/410014661137336)
