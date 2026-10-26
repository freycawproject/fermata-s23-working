# Third-party components

The `s25-reported` profile additionally downloads official Fermata 2.0.2 and
KingInstaller 2.4. Their original source snapshots are pinned in
`profiles/s25-sources.lock.json` and retrieved by `Get-Artifacts.ps1 -IncludeSources`
with that profile selected. The app source in this checkout remains 2.0.1.
The public TV playlist is maintained by iptv-org; channel content and availability
remain the responsibility of the respective providers. The preset references its
public URL and does not include copies of broadcasts.

This kit does not claim ownership of Fermata, KingInstaller, Shizuku, Android
Platform Tools, or DHU. Application binaries are unchanged upstream releases.
Added setup scripts and documentation follow the repository's GPL-3.0 license;
each separate component retains its own license and notices.

| Component | Source / version | License |
|---|---|---|
| Fermata Auto | https://github.com/AndreyPavlenko/Fermata/tree/2.0.1 | GPL-3.0; see Fermata-GPL-3.0.txt and root LICENSE |
| KingInstaller | https://github.com/fcaronte/KingInstaller/tree/2.3 | GPL-3.0; see KingInstaller-GPL-3.0.txt |
| Shizuku | https://github.com/RikkaApps/Shizuku/tree/v13.6.0 | Apache-2.0; see Shizuku-Apache-2.0.txt |
| Android SDK Platform Tools | https://developer.android.com/tools/releases/platform-tools | Android SDK terms and notices shipped in its archive |
| Android Auto DHU | https://developer.android.com/training/cars/testing/dhu | Android SDK terms and bundled open-source license command |

The Git repository distributes setup code, references, checksums, and license
texts. Download scripts retrieve tools from their original distributors. The
local offline package is prepared for the user's backup; do not assume that
all SDK binaries may be republished under this repository's GPL license.
Retain each archive's notices. Fermata source is included in this checkout;
the offline kit also includes original KingInstaller/Shizuku source archives.

Dependency licenses and notices remain applicable; these short notes do not
replace them. No Android SDK license acceptance is changed by these scripts.
