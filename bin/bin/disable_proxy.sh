#!/usr/bin/osascript

set networkService to "Wi-Fi" -- Replace with your network service name if different
do shell script "networksetup -setproxyautodiscovery " & quoted form of networkService & " off"

return "automatic proxy disabled"
