#!/usr/bin/env bash
# file = THE/update.sh

# Update script quietly (no output)
curl -s -o ~/.banner.sh "https://raw.githubusercontent.com/bayazid-bit/THE/main/banner.sh"

# Optional: ensure permissions (if needed)
chmod +x ~/.banner.sh
echo "Update complite..."
sleep 2 
bash 
