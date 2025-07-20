#!/usr/bin/env bash
# file = THE/uninstall.sh

echo -e "\n🧹 Uninstalling Termux Hacker Info Panel..."

# Remove autostart entry from ~/.bashrc
if grep -q 'bash ~/.banner.sh' ~/.bashrc; then
    sed -i '/bash ~/.banner.sh/d' ~/.bashrc
    echo "✔️ Removed autostart entry from ~/.bashrc"
else
    echo "ℹ️ No autostart entry found in ~/.bashrc"
fi

# Remove background update call from ~/.bashrc
if grep -q 'nohup bash ~/.update.sh >/dev/null 2>&1 &' ~/.bashrc; then
    sed -i '/nohup bash ~/.update.sh >/dev/null 2>&1 &/d' ~/.bashrc
    echo "✔️ Removed background update entry from ~/.bashrc"
else
    echo "ℹ️ No background update entry found in ~/.bashrc"
fi

# Remove the actual scripts if exist
if [ -f ~/.banner.sh ]; then
    rm ~/.banner.sh
    echo "✔️ Removed ~/.banner.sh"
else
    echo "ℹ️ ~/.banner.sh not found."
fi

if [ -f ~/.update_banner.sh ]; then
    rm ~/.update_banner.sh
    echo "✔️ Removed ~/.update.sh"
else
    echo "ℹ️ ~/.update.sh not found."
fi

echo -e "\n✅ Uninstallation complete. Please restart Termux."

