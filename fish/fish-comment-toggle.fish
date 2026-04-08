set line (commandline)
if test -n "$line"
    set cursor (commandline --cursor)
    if string match -rq '^\s*#' -- $line
        # Remove leading "# " (or "#", with optional spaces after)
        set newline (string replace -r '^[ #]+' '' -- $line)
        commandline --replace $newline
        # Calculate the new cursor position
        set removed (string replace -r '^([ #]+).*' '\1' -- $line)
        set removed_len (string length $removed)
        if test $cursor -gt $removed_len
            commandline --cursor (math $cursor - $removed_len)
        else
            commandline --cursor 0
        end
    else
        # Add "# " at the start
        set newline "# $line"
        commandline --replace $newline
        # To keep the cursor position, just move it left by 2
        commandline --cursor (math $cursor + 2)
    end

end
