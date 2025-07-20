#!/usr/bin/env bash

#file = THE/install.sh

pkg update -y && pkg upgrade -y
pkg install -y termux-api jq inetutils coreutils bash

termux-setup-storage

# Check and copy .banner.sh
if [ -f ".banner.sh" ]; then
    cp .banner.sh ~/.banner.sh
else
    echo "❌ Warning: .banner.sh file not found in current directory!"
fi

# Check and copy .update_banner.sh (optional, if তুমি রাখো)
if [ -f ".update_banner.sh" ]; then
    cp ./update.sh ~/.update_banner.sh
    chmod +x ~/.update_banner.sh
else
    echo "⚠️ Note: .update_banner.sh not found. Update feature will not work."
fi

# Add autostart entry for .banner.sh if not already present
grep -qxF 'bash ~/.banner.sh' ~/.bashrc || echo 'bash ~/.banner.sh' >> ~/.bashrc

# Add background update call if not already present
grep -qxF 'nohup bash ~/.update_banner.sh >/dev/null 2>&1 &' ~/.bashrc || echo 'nohup bash ~/.update_banner.sh >/dev/null 2>&1 &' >> ~/.bashrc

echo -e "\n📢 If your WiFi SSID shows null, go to:"
echo -e "Settings → Apps → Termux → Permissions → Allow Location"
echo -e "\n✅ Setup complete. Please restart Termux to see your hacker info panel!"

