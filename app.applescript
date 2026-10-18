on run
	set res to (path to me as text) & "Contents:Resources:"
	set wf to POSIX path of res & "Convert to MP4.workflow"
	do shell script "mkdir -p ~/Library/Services && rm -rf ~/Library/Services/'Convert to MP4.workflow' && cp -R " & quoted form of wf & " ~/Library/Services/ && xattr -dr com.apple.quarantine ~/Library/Services/'Convert to MP4.workflow'; /System/Library/CoreServices/pbs -update >/dev/null 2>&1; true"
	display dialog "All set! ✅" & return & return & "Now just right-click any .mov video in Finder → Quick Actions → Convert to MP4 (the MP4s go into a \"Converted MP4\" folder next to the video)." buttons {"Done"} default button "Done" with title "Convert to MP4"
end run

on open theFiles
	set ok to 0
	set bad to 0
	repeat with f in theFiles
		set src to POSIX path of f
		set dirOf to (do shell script "dirname " & quoted form of src) & "/"
		set baseName to do shell script "b=$(basename " & quoted form of src & "); echo \"${b%.*}\""
		do shell script "mkdir -p " & quoted form of (dirOf & "Converted MP4")
		set outPath to dirOf & "Converted MP4/" & baseName & ".mp4"
		set n to 1
		repeat while (do shell script "[ -e " & quoted form of outPath & " ] && echo y || echo n") is "y"
			set outPath to dirOf & "Converted MP4/" & baseName & " (" & n & ").mp4"
			set n to n + 1
		end repeat
		try
			do shell script "/usr/bin/avconvert --source " & quoted form of src & " --output " & quoted form of outPath & " --preset PresetHighestQuality"
			set ok to ok + 1
		on error
			do shell script "rm -f " & quoted form of outPath
			set bad to bad + 1
		end try
	end repeat
	display notification "Converted " & ok & " file(s) to MP4" with title "Convert to MP4"
	delay 1
end open
