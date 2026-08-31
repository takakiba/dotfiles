#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Safari Private
# @raycast.mode silent

tell application "Safari"
	activate

	set foundWindow to false

	repeat with w in windows
		set windowName to name of w

		if windowName does not start with "Personal —" and windowName does not start with "Work —" then
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
			click menu item "New Private Window" of menu "File" of menu bar 1
		end tell
	end tell
end if
