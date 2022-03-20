[bar/top]
myscript-background = #f00
myscript-command = whoami

[bar/bottom]
myscript-background = #f00
myscript-command = date +%s

[module/myscript]
format-background = ${root.myscript-background}
exec = ${root.myscript-command}
