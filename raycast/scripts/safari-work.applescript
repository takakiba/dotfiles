#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Safari Work
# @raycast.mode silent

tell application "Safari"
	activate

	set foundWindow to false

	repeat with w in windows
		if name of w starts with "Work" then
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
			try
				click menu item "New Work Window" of menu "New Window" of menu item "New Window" of menu "File" of menu bar 1
			on error
				click menu item "New Work Window" of menu "File" of menu bar 1
			end try
		end tell
	end tell
end if
