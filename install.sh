#!/usr/bin/env bash

#file = THE/install.sh

pkg update -y && pkg upgrade -y
pkg install -y termux-api jq inetutils coreutils bash

termux-setup-storage

if [ -f "./banner.sh" ]; then
    cp ./banner.sh ~/.banner.sh
else
    echo "❌ Warning: banner.sh file not found in current directory!"
fi


if [ -f "./update.sh" ]; then
    cp ./update.sh ~/.update.sh
    chmod +x ~/.update.sh
else
    echo "⚠️ Note: update.sh not found. Update feature will not work."
fi


grep -qxF 'source ~/.banner.sh' ~/.bashrc || echo 'source ~/.banner.sh' >> ~/.bashrc

# Add background update call if not already present
grep -qxF 'nohup bash ~/.update.sh >/dev/null 2>&1 & disown' ~/.bashrc || echo 'nohup bash ~/.update.sh >/dev/null 2>&1 & disown' >> ~/.bashrc

echo -e "\n📢 If your WiFi SSID shows null, go to:"
echo -e "Settings → Apps → Termux → Permissions → Allow Location"
echo -e "\n✅ Setup complete. Please restart Termux to see your hacker info panel!"

