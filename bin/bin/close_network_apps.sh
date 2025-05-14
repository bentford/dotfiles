#!/usr/bin/osascript

try
    tell application "Cisco Secure Client" to quit
    return "Cisco Secure Client quit successfully."
on error errMsg number errNum
    if errNum ≠ -128 then
        return "Error: " & errMsg & " (" & errNum & ")"
    end if
end try

tell application "Proxyman" to quit
