## fritzbox-clear-reboot script
This is a Linux bash script that allows you to clear and reboot your FRITZ!Box router and/or FRITZ!WLAN Repeater running on FRITZ!OS < 7.50 and higher.

## Features
The script includes the following features, which can be enabled or disabled as desired by commenting them out in the script:

1. Remove unused LAN clients.
2. Remove unused WLAN clients.
3. Remove failed WLAN clients.
4. Reset online meter.
5. Reboot router/repeater.

## Usage

To use the script, simply download it and make it executable **(chmod +x fritz-reboot.sh)**. Then, adjust the following settings in the script to match your FRITZ! device:

| Default value                 |                                   |
| ----------------------------- |:---------------------------------:|
| FRITZ_HOST="192.168.1.1"      | **Your FRITZ! device ip address** |
| FRITZ_USER="fritz7777"        | **Your FRITZ! device username**   |
| FRITZ_PASSWORD="YourPassword" | **Your FRITZ! device password**   |

After adjusting the settings, run the script with **./fritz-reboot.sh**

## Future improvements
This script is open to future improvements based on feedback and popularity. Please feel free to open an issue to suggest improvements or report bugs.
