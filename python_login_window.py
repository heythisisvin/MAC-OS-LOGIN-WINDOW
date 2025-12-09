import subprocess
import os

def trigger_fast_user_switch_login_window():
    """
    Triggers the macOS Login Window, which immediately presents the
    Fast User Switching interface showing all user accounts.
    This replaces the deprecated CGSession -suspend command.
    """
    # AppleScript to simulate pressing the F14 key (key code 110)
    # The F14 key is the standard system shortcut for 'Show Login Window'
    applescript_command = 'tell application "System Events" to key code 110'

    print("Attempting to trigger the Fast User Switching Login Window...")
    
    try:
        # osascript is the shell command to run AppleScript
        command = ["osascript", "-e", applescript_command]
        
        # Execute the command
        result = subprocess.run(command, check=True, capture_output=True, text=True)
        
        if result.returncode == 0:
            print("Command executed successfully. The user list should now be visible.")
            return True
        else:
            print(f"AppleScript failed with return code {result.returncode}.")
            print("This usually means Accessibility permissions are missing.")
            return False

    except subprocess.CalledProcessError as e:
        print(f"Execution Error: {e.stderr.strip()}")
        return False
    except FileNotFoundError:
        print("Error: osascript command not found.")
        return False

# --- IMPORTANT SETUP REQUIRED ---
# If running this script directly in a terminal:
# 1. Open System Settings > Privacy & Security > Accessibility.
# 2. Add your Terminal application (e.g., Terminal.app, iTerm.app) to the list
#    and ensure its switch is ON. Key presses must be authorized by the system.

# Example usage (will lock the screen and immediately present the user selection interface)
# if os.environ.get('TERM_PROGRAM'):
#     # Prevents running inside environments that might not have accessibility permissions
#     # Uncomment the line below when you are ready to test on your machine
#     trigger_fast_user_switch_login_window()
# else:
#     print("Script is currently disabled to prevent unexpected lock screen when running in certain environments.")
