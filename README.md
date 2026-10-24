## Samsung S23: konfigurasi yang teruji

Branch ini berangkat dari source Fermata **2.0.1**, commit
`7be970dbc1d68f674886af3e9a4e4ad838e56bc4`. Kode aplikasi upstream tidak diubah.
Tambahan ada di **[samsung-setup/README.id.md](samsung-setup/README.id.md)**:
versi APK yang dipatok, checksum, KingInstaller 2.3, Shizuku opsional, DHU 2.1,
skrip PowerShell, dan **[prompt pemasangan](samsung-setup/prompts/SETUP.id.md)**.

Fermata Auto dan video YouTube berhasil diuji di DHU pada Galaxy S23 / Android 16 /
One UI 8.5 / Android Auto 17.8.663874. Pemasangan berhasil melalui KingInstaller
metode biasa; tidak memerlukan Shizuku atau root pada perangkat yang diuji.
Hasil di head unit mobil fisik belum diverifikasi. APK di kit adalah rilis resmi
upstream, bukan hasil build ulang dari fork ini.

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
