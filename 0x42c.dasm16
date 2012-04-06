SET PC, initialstate

:version dat "0x42c v.0.1 128K MEM READY", 0
:input dat "> ", 0
:lol dat "Lololol.", 0
:reddit dat "reddit", 0
:date dat "date", 0
:clean dat "clean", 0
:vers dat "version", 0
:redditoutput dat "Reddit, the frontpage of the internet.", 0
:dateoutput dat "00:00:00 UTC on 1 January 1970", 0
:unrecognized dat "Unrecognized command.", 0

:initialstate
set [0x1335], 0x8000   ; vidmem
set [0x1337], 0x1338 ; input buffer


:main

set a, version
jsr printnl

:inputready
set a, input
jsr print

set pc, kbloop

:kbloop

ife [0x9000], 0
set pc, kbloop
ife [0x9000], 0xA
jsr enteredcommand
ife [0x9000], 0x8 ; backspace
jsr backspace

set a, [0x9000]
jsr printchar

set a, [0x1337]
set b, [0x9000]
jsr strcat
add [0x1337], 1

set [0x9000], 0

set pc, kbloop

:backspace
set a, [0x1337]
set [a], 0
sub [0x1337], 1
sub [0x1335], 1
set a, 0
jsr printchar
sub [0x1335], 1
set [0x9000], 0
set pc, kbloop

:reset
set [0x1337], 0x1338 ; reset pointer
set [0x1338], 0        ; reset string
set [0x9000], 0      ; reset keyboard
set [0x1336], 0      ; reset command recognized
set pc, pop

:enteredcommand
set a, reddit
set b, 0x1338
jsr strcmp
ife y, 1
jsr redditf

set a, date
set b, 0x1338
jsr strcmp
ife y, 1
jsr datef

set a, clean
set b, 0x1338
jsr strcmp
ife y, 1
jsr cleanf

set a, vers
set b, 0x1338
jsr strcmp
ife y, 1
jsr versionf


ifn [0x1336], 1
jsr unrecognizedf

jsr reset

set pc, inputready

:cleanf
set [0x1336], 1
set [0x1335], 0x8000
:clean_print
ifg [0x1335], 0x81ff
set pc, pop
set a, [0x1335]
set [a], 256
add [0x1335], 1
set pc, clean_print

:versionf
jsr newline
jsr reset
set pc, main

:unrecognizedf
jsr newline
set a, unrecognized
jsr printnl

set pc, pop

:redditf
set [0x1336], 1 ; acknowledge recognized command

jsr printnl
set a, redditoutput
jsr printnl
set pc, pop

:datef
set [0x1336], 1 ; acknowledge recognized command

jsr printnl
set a, dateoutput
jsr printnl
set pc, pop

:strcmp
set y, 0

ife [a], [b]
jsr checkzero

ife y, 1
set pc, pop

ifn [a], [b]
set pc, pop

add a, 1
add b, 1
set pc, strcmp

:checkzero
ife [a], 0
set y, 1
set pc, pop

:strcat
set [a], b
add a, 1
set [a], 0
set pc, pop


:printnl   ; shortcut
jsr print
jsr newline
set pc, pop

:print
set i, a
:doprint
ifg [0x1335], 0x81ff ; end of vidmem
set [0x1335], 0x8000
ife [i], 0
set pc, pop
set a, [i]
jsr printchar
add i, 1
set pc, doprint

:printchar
set b, [0x1335]
bor a, 0xf100 ; color :D
set [b], a
add [0x1335], 1
set pc, pop

:newline

set i, [0x1335]
mod i, 32 ; width
set z, 32
sub z, i
add [0x1335], z
set pc, pop

:end set pc, end
