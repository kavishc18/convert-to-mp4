# Convert to MP4 for Mac

Right-click any `.mov` in Finder and convert it to `.mp4`. Free, no Terminal, no ffmpeg — it uses the video converter built into macOS.

## Install
1. Download **ConvertToMP4.dmg** from the [latest release](../../releases/latest).
2. Drag **Convert to MP4** into Applications.
3. Open it once. On first open macOS may warn about an unidentified developer: right-click the app → **Open** → **Open**.
4. Done.

## Use
Right-click a `.mov` → **Convert to MP4** (or **Quick Actions → Convert to MP4**).
The MP4 appears in a `Converted MP4` folder next to the original. Originals are never touched.

You can also drag `.mov` files onto the app, or right-click → Open With → Convert to MP4.

## How it works
Everything is a few lines of shell/AppleScript — read `app.applescript` and `convert.sh`. It calls `/usr/bin/avconvert` (part of macOS). The app installs a Finder Quick Action into `~/Library/Services` on first launch; delete `~/Library/Services/Convert to MP4.workflow` to uninstall.

MIT licensed.
