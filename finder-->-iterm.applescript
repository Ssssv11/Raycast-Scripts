#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Finder -> iTerm
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Open current Finder directory in iTerm
# @raycast.author Ssssv

tell application "Finder"
	set pathList to (quoted form of POSIX path of (folder of the front window as alias))
	set command to "clear; cd " & pathList
end tell

tell application "System Events"
	-- some version might identify as "iTerm2" instead of "iTerm"
	set isRunning to (exists (processes where name is "iTerm")) or (exists (processes where name is "iTerm2"))
end tell

tell application "iTerm"
	activate
	set hasNoWindows to ((count of windows) is 0)
	if isRunning and hasNoWindows then
		create window with default profile
	end if
	repeat while (count of windows) is 0
		delay 0.5
	end repeat	
	select first window
	
	tell the first window
		if isRunning and hasNoWindows is false then
			create tab with default profile
		end if
		tell current session to write text command
	end tell
end tell

