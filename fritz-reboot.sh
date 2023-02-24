#!/bin/sh

FRITZ_HOST="192.168.1.1"
FRITZ_USER="fritz7777"
FRITZ_PASSWORD="YourPassword"

CURLCMD="curl --insecure -s"
CURLDEF="https://${FRITZ_HOST}"
CURL="$CURLCMD $CURLDEF"

sidfb(){
    challenge=`$CURL/login_sid.lua|grep -Po '(?<=<Challenge>).*(?=</Challenge>)'`
    md5_key=`echo -n "$challenge-$FRITZ_PASSWORD"|iconv -f ISO8859-1 -t UTF-16LE|md5sum -b|awk '{print substr($0,1,32)}'`
    SID=`$CURLCMD -G -d "username=$FRITZ_USER" -d "response=$challenge-$md5_key" "$CURLDEF/login_sid.lua"|grep -Po '(?<=<SID>).*(?=</SID>)'`
}

sidfb
echo "Rebooting $FRITZ_HOST using SID $SID"

# Remove unused LAN clients:
$CURL/data.lua --data-raw "xhr=1&Connection=on&IP+Address=on&Properties=on&cleanup=&sid=$SID&lang=en&page=netDev" 1>/dev/null

# Remove unused WLAN clients:
$CURL/data.lua --data-raw "xhr=1&sid=$SID&lang=en&page=wSet&xhrId=cleanupWlanClients&useajax=1&no_sidrenew=" 1>/dev/null

# Remove failed WLAN clients:
$CURL/data.lua --data-raw "xhr=1&sid=$SID&lang=en&page=wSet&xhrId=cleanupFailClients&useajax=1&no_sidrenew=" 1>/dev/null

# Reset online meter:
$CURL/data.lua --data-raw 'xhr=1&sid=$SID&reset=1&oldpage=%2Finternet%2Finetstat_counter.lua&page=netCnt' 1>/dev/null

# Reboot router:
$CURL/data.lua --data-raw "xhr=1&sid=$SID&reboot=1&lang=en&page=reboot" 1>/dev/null
$CURL/reboot.lua --data-raw "ajax=1&sid=$SID&no_sidrenew=1&xhr=1&useajax=1" 1>/dev/null
