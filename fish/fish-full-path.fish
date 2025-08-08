# Get the current commandline and cursor position
set cmd (commandline)
set pos (commandline -C)
set diff 0
if test $pos -eq 0
    # Move 1 right if we are at the start of the line so that
    # we get 1 char token and add the cwd
    set pos 1
    set diff -1
else
    # Move cursor left until it lands on a non-space character
    while test $pos -gt 0
        set char (string sub -s $pos -l 1 -- $cmd)
        if test "$char" != ' '
            break
        end
        set pos (math $pos - 1)
        set diff (math $diff + 1)
    end
end
set before (string sub -l $pos -- $cmd)
set after (string sub -s (math $pos + 1) -- $cmd)
# Use regex to find the last token before cursor that resembles a file path
set token (string match -r '[^ \t\n\r\f\v]+$' -- $before)
if test -z "$token"
    return
end
set full (realpath $token 2>/dev/null)
if test -z "$full"
    return
end
# Replace the token in the commandline with the full path
set new_before (string replace -r '[^ \t\n\r\f\v]+$' "$full" -- $before)
commandline -r "$new_before$after"
# Move cursor to end of full path
commandline -C (math (string length -- $new_before) + $diff)
