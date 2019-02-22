Shell parameter substitutions
-----------------------------

<https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html>

    # $ FILE="example.tar.gz"
    # $ echo "${FILE%%.*}"      # => example
    # $ echo "${FILE%.*}"       # => example.tar
    # $ echo "${FILE#*.}"       # => tar.gz
    # $ echo "${FILE##*.}"      # => gz
    # $ basename $FILE .gz      # => example.tar
    # $ basename $FILE .tar.gz  # => example
    # ${variable%pattern}       # Trim the shortest match from the end
    # ${variable##pattern}      # Trim the longest match from the beginning
    # ${variable%%pattern}      # Trim the longest match from the end
    # ${variable#pattern}       # Trim the shortest match from the beginning


Colors
------

### `LSCOLORS`

The color designators are as follows:

* a black
* b red
* c green
* d brown
* e blue
* f magenta
* g cyan
* h light grey
* A bold black/dark grey
* B bold red
* C bold green
* D bold brown/yellow
* E bold blue
* F bold magenta
* G bold cyan
* H bold light grey / bright white
* x default fg or bg

Note that the above are standard ANSI colors. The actual display may differ depending on the color
capabilities of the terminal in use.

The order of the attributes are as follows:

* 1.  directory
* 2.  symbolic link
* 3.  socket
* 4.  pipe
* 5.  executable
* 6.  block special
* 7.  character special
* 8.  executable with setuid bit set
* 9.  executable with setgid bit set
* 10. directory writable to others, with sticky bit
* 11. directory writable to others, without sticky bit

`\[{attr};{fg};{bg}m`

The first character is `ESC` which has to be printed by pressing `CTRL+V` and then `ESC` on the
Linux console or in xterm, konsole, kvt, etc. (`CTRL+V ESC` is also the way to embed an
escape character in a document in vim.).

Then `{attr}`, `{fg}`, `{bg}` have to be replaced with the correct value to get the corresponding effect.
`attr` is the attribute like blinking or underlined etc. `fg` and `bg` are foreground and background colors respectively.
You don't have to put braces around the number. Just writing the number will suffice.

`{attr}` is one of following:

* `0`   Reset All (normal mode)
* `1`   Bright
* `2`   Dim
* `3`   Underline
* `5`   Blink
* `7`   Reverse
* `8`   Hidden

`{fg}` is one of the following:

* `30` Black
* `31` Red
* `32` Green
* `33` Yellow
* `34` Blue
* `35` Magenta
* `36` Cyan
* `37` White

`{bg}` is one of the following:

* `40` Black
* `41` Red
* `42` Green
* `43` Yellow
* `44` Blue
* `45` Magenta
* `46` Cyan
* `47` White

