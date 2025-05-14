#!/usr/bin/osascript

set networkService to "Wi-Fi" -- Replace with your network service name if different
set proxyStatus to do shell script "networksetup -getautoproxyurl " & quoted form of networkService

if proxyStatus contains "Enabled: Yes" then
    return "Autoproxy is enabled"
else
    return "Autoproxy is disabled"
end if
