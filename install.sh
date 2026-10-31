#!/usr/bin/env bash
set -euo pipefail

echo "Installing ThinkPad PrivacyGuard KDE OSD & Brightness Service..."

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/systemd/user"

install -m 755 privacyguard-osd "$HOME/.local/bin/privacyguard-osd"
install -m 644 privacyguard-osd.service "$HOME/.config/systemd/user/privacyguard-osd.service"

if [ -e /proc/acpi/ibm/lcdshadow ]; then
    echo "Configuring PrivacyGuard default state (off at boot) via /etc/tmpfiles.d/privacyguard.conf..."
    pkexec sh -c 'echo 0 > /proc/acpi/ibm/lcdshadow && echo "w /proc/acpi/ibm/lcdshadow - - - - 0" > /etc/tmpfiles.d/privacyguard.conf'
fi

systemctl --user daemon-reload
systemctl --user enable --now privacyguard-osd.service

echo "Done! Press Fn + D to test PrivacyGuard."
