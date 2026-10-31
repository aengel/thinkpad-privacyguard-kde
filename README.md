# ThinkPad PrivacyGuard for KDE Plasma (Linux)

Lightweight daemon for Lenovo ThinkPads with **PrivacyGuard (ePrivacy)** displays (such as the ThinkPad X13 Gen 2 / X13 Yoga Gen 2, T14, X1 Carbon, etc.) running **KDE Plasma** on Linux.

## The Problem on Linux

On ThinkPads equipped with an electronic PrivacyGuard panel (e.g. Coretronic `LEB13201N-WJ`), pressing **`Fn + D`** toggles the hardware privacy pin (`GPP_D14`) and Embedded Controller flag via `thinkpad_acpi` (`/proc/acpi/ibm/lcdshadow`), **but**:

1. **No On-Screen Display (OSD):** Unlike Windows (Lenovo Vantage), Linux shows no visual indicator when `Fn + D` is pressed, making it hard to tell whether PrivacyGuard is currently enabled (`1`) or disabled (`0`).
2. **100% Backlight Overpowers the ePrivacy Filter:** Hardware ePrivacy panels rely on a switchable liquid-crystal layer whose side-angle blocking effect scales inversely with backlight luminance. At high brightness (70–100%), the backlight physically overpowers the filter, so looking from the side shows almost no difference. On Windows, the Lenovo driver automatically reduces brightness when PrivacyGuard is enabled and restores it when disabled.
3. **Enabled by Default on Boot:** Many ThinkPads boot with `lcdshadow` set to `1` (`Enabled`), needlessly dimming and narrowing the display's viewing angles even when PrivacyGuard is not wanted.

## What This Tool Does

- **Native KDE Plasma OSD Popup:** Listens for DRM `change` uevents (`udevadm monitor`) with zero CPU polling overhead and displays a native KDE Plasma OSD notification (`PrivacyGuard: Eingeschaltet` / `PrivacyGuard: Ausgeschaltet`) whenever `Fn + D` is pressed.
- **Automatic Privacy Brightness:** Automatically lowers display brightness to `25%` when PrivacyGuard is turned **ON** (so side viewing angles immediately go dark) and restores your previous brightness level as soon as PrivacyGuard is turned **OFF**.
- **Default Off at Boot:** Configures `/etc/tmpfiles.d/privacyguard.conf` so PrivacyGuard starts **OFF (`0`)** on every boot.

## Installation

```bash
git clone https://github.com/aengel/thinkpad-privacyguard-kde.git
cd thinkpad-privacyguard-kde
./install.sh
```

## Manual Control

You can also check or toggle the hardware state via `/proc/acpi/ibm/lcdshadow`:

```bash
cat /proc/acpi/ibm/lcdshadow
# Enable PrivacyGuard:
echo 1 | sudo tee /proc/acpi/ibm/lcdshadow
# Disable PrivacyGuard:
echo 0 | sudo tee /proc/acpi/ibm/lcdshadow
```

## License

MIT
