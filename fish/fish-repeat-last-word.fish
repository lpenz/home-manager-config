set cmd (commandline)
set pos (commandline -C)
set len (string length -- $cmd)

# Move cursor right until we hit a space (word end)
while test $pos -lt $len
    set char (string sub -s (math $pos + 1) -l 1 -- $cmd)
    if test "$char" = ' '
        break
    end
    set pos (math $pos + 1)
end

# Move cursor left to first non-space
while test $pos -gt 0
    set char (string sub -s $pos -l 1 -- $cmd)
    if test "$char" != ' '
        break
    end
    set pos (math $pos - 1)
end

# Text before and after this point
set before (string sub -l $pos -- $cmd)
set after (string sub -s (math $pos + 1) -- $cmd)

# Extract the last "bigword" (non-whitespace sequence)
set word (string match -r '[^ \t\n\r\f\v]+$' -- $before)
if test -z "$word"
    echo "No word to duplicate."
    return 1
end

# Insert a space and then the duplicate of the word
set new_before "$before $word"

# Replace the commandline and adjust cursor
commandline -r "$new_before$after"
commandline -C (string length -- $new_before)
