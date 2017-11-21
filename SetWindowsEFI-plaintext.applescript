on toggleEFI()
	tell application "Finder"
		--activate
		if exists disk "EFI" then
			do shell script "diskutil umount EFI"
		else
			try
				do shell script "diskutil mount EFI"
			end try
		end if
	end tell
end toggleEFI

tell application "System Events"
	try
		do shell script "diskutil mount EFI"
	end try
	
	set plistFile to property list file "/Volumes/EFI/EFI/CLOVER/config.plist"
	tell plistFile
		tell property list item "Boot"
			set value of property list item "DefaultVolume" to "HD(3,GPT,7F76079C-5CB6-4E5F-8E24-9B8681E9996B,0x140800,0x1CFA3800)"
			set value of property list item "DefaultLoader" to "\\EFI\\Microsoft\\Boot\\bootmgfw.efi"
		end tell
	end tell
end tell

--tell application "Finder" to restart