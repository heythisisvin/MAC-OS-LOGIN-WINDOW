#!/bin/bash
# Run the AppleScript to open the Login Window (Fast User Switching -> Login Window)
# Requires Accessibility/Automation permissions for the calling app (Terminal / Script Editor / runner).

osascript <<'APPLESCRIPT'
tell application "System Events"
    tell process "SystemUIServer"
        set targetMBI to missing value
        set mbItems to every menu bar item of menu bar 1
        repeat with mbi in mbItems
            try
                set m to menu 1 of mbi
                set itemNames to name of every menu item of m
                if itemNames contains "Login Window…" or itemNames contains "Login Window..." or itemNames contains "Login Window" then
                    set targetMBI to mbi
                    exit repeat
                end if
            end try
        end repeat

        if targetMBI is not missing value then
            click targetMBI
            delay 0.15
            try
                if (exists menu item "Login Window…" of menu 1 of targetMBI) then
                    click menu item "Login Window…" of menu 1 of targetMBI
                else if (exists menu item "Login Window..." of menu 1 of targetMBI) then
                    click menu item "Login Window..." of menu 1 of targetMBI
                else if (exists menu item "Login Window" of menu 1 of targetMBI) then
                    click menu item "Login Window" of menu 1 of targetMBI
                else
                    click (first menu item of menu 1 of targetMBI whose name starts with "Login Window")
                end if
            on error errMsg
                error "Failed to click Login Window menu item: " & errMsg
            end try
        else
            error "Could not find the Fast User Switching / User menu containing a 'Login Window' menu item. Make sure Fast User Switching is enabled."
        end if
    end tell
end tell
APPLESCRIPT