Scripts
=======

Scripts, configurations, and setup for macOS and Linux

    cd ~
    git clone https://github.com/dakrauth/scripts
    ./scripts/setup.sh

Summary
-------

    ├── Brewfile      # a Homebrew Gem-like file for installation
    ├── README.md     # your reading it now
    ├── bash/         # contextual files to be sourced via dotfiles/bashrc
    ├── bin/          # various executable scripts to be symlinked into $HOME/bin
    ├── dotfiles/     # various config files to be symlinked into $HOME
    ├── downloads.sh  # files to download that aren't available elsewise
    └── setup.sh      # initial a new user account

See `vw.help` for details about `vw`.

Bash Quick Docs
===============

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

Shell variables
---------------

* `$1`, `$2`, `$3`, ... are the [positional parameters](https://www.gnu.org/software/bash/manual/html_node/Positional-Parameters.html).
* `"$@"` is an array-like construct of all positional parameters, `{$1, $2, $3 ...}`.
* `"$*"` is the IFS expansion of all positional parameters, `$1 $2 $3 ...`.
* `$#` is the number of positional parameters.
* `$-` current options set for the shell.
* `$$` pid of the current shell (not subshell).
* `$_` most recent parameter (or the abs path of the command to start the current shell immediately after startup).
* `$IFS` is the (input) field separator.
* `$?` is the most recent foreground pipeline exit status.
* `$!` is the PID of the most recent background command.
* `$0` is the name of the shell or shell script.

[Special Parameters](https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html).  
[All environment variables set by the shell](https://www.gnu.org/software/bash/manual/html_node/Shell-Variables.html).  
[Reference Manual Variable Index](https://www.gnu.org/software/bash/manual/html_node/Variable-Index.html).

File tests, returns true if...
------------------------------

* `-e` file exists
* `-a` file exists. This is identical in effect to -e. It has been "deprecated," [1] and its use is discouraged.
* `-f` file is a regular file (not a directory or device file)
* `-s` file is not zero size
* `-d` file is a directory
* `-b` file is a block device
* `-c` file is a character device
* `-p` file is a pipe
* `-h` file is a symbolic link
* `-L` file is a symbolic link
* `-S` file is a socket
* `-t` file (descriptor) is associated with a terminal device
* `-r` file has read permission (for the user running the test)
* `-w` file has write permission (for the user running the test)
* `-x` file has execute permission (for the user running the test)
* `-g` set-group-id (sgid) flag set on file or directory
* `-u` set-user-id (suid) flag set on file
* `-k` sticky bit set
* `-O` you are owner of file
* `-G` group-id of file same as yours
* `-N` file modified since it was last read
* `f1 -nt f2` file f1 is newer than f2
* `f1 -ot f2` file f1 is older than f2
* `f1 -ef f2` files f1 and f2 are hard links to the same file
* `!` "not" -- reverses the sense of the tests above (returns true if condition absent).

Colors
------

### `LSCOLORS`

The color designators are as follows:

* `a` black
* `b` red
* `c` green
* `d` brown
* `e` blue
* `f` magenta
* `g` cyan
* `h` light grey
* `A` bold black/dark grey
* `B` bold red
* `C` bold green
* `D` bold brown/yellow
* `E` bold blue
* `F` bold magenta
* `G` bold cyan
* `H` bold light grey / bright white
* `x` default fg or bg

Note that the above are standard ANSI colors. The actual display may differ depending on the color
capabilities of the terminal in use.

The order of the attributes are as follows:

1.  directory
2.  symbolic link
3.  socket
4.  pipe
5.  executable
6.  block special
7.  character special
8.  executable with setuid bit set
9.  executable with setgid bit set
10. directory writable to others, with sticky bit
11. directory writable to others, without sticky bit

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

