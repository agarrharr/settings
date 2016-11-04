#!/usr/bin/env osascript

set save_location to ¬
    (choose folder with prompt "Choose where to save screenshots")

repeat with shotcount from 1 to 100
    do shell script "screencapture -x " & ¬
        quoted form of POSIX path of save_location ¬
        & "screen" & (shotcount as string)
    delay (60 * 1) -- delay one minute
end repeat
