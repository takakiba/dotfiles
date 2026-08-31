#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Safari Personal
# @raycast.mode silent

tell application "Safari"
	activate

	set foundWindow to false

	repeat with w in windows
		if name of w starts with "Personal" then
			set miniaturized of w to false
			set index of w to 1
			set foundWindow to true
			exit repeat
		end if
	end repeat
end tell

if not foundWindow then
	tell application "System Events"
		tell process "Safari"
			-- Safariのバージョンによってメニュー階層が異なるので両方に対応
			try
				click menu item "New Personal Window" of menu "New Window" of menu item "New Window" of menu "File" of menu bar 1
			on error
				click menu item "New Personal Window" of menu "File" of menu bar 1
			end try
		end tell
	end tell
end if
