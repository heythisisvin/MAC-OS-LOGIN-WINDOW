tell application "System Events"
    tell process "SystemUIServer"
        set targetMBI to missing value
        -- iterate menu bar items looking for a menu that contains a "Login Window" menu item
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
            -- attempt to click the Login Window item (handles ellipsis variants)
            try
                if (exists menu item "Login Window…" of menu 1 of targetMBI) then
                    click menu item "Login Window…" of menu 1 of targetMBI
                else if (exists menu item "Login Window..." of menu 1 of targetMBI) then
                    click menu item "Login Window..." of menu 1 of targetMBI
                else if (exists menu item "Login Window" of menu 1 of targetMBI) then
                    click menu item "Login Window" of menu 1 of targetMBI
                else
                    -- fallback: click the first menu item that starts with "Login Window"
                    click (first menu item of menu 1 of targetMBI whose name starts with "Login Window")
                end if
            on error errMsg
                -- surface a clear error if clicking fails
                error "Failed to click Login Window menu item: " & errMsg
            end try
        else
            error "Could not find the Fast User Switching / User menu containing a 'Login Window' menu item. Make sure Fast User Switching is enabled in Settings → Users & Groups → Login Options."
        end if
    end tell
end tell