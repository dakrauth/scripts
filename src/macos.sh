# See README.md
export LSCOLORS="GxFxdadxDxegedabagAcad"

export SDKROOT="$(xcrun --show-sdk-path)"
export MACOSX_DEPLOYMENT_TARGET="$(sw_vers -productVersion)"    # e.g.: 10.14

export PICKER_DB_PORT=3306
#export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export BAT_THEME=OneHalfLight

if [ $ITERM_SESSION_ID ]; then
    export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
    # export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

function vts2iso() {
    discname=`basename "${1%.*}"`
    echo "$discname"
    hdiutil makehybrid -udf -udf-volume-name "$discname" -o "$discname".iso "$1"
}

function sysinfo() {
    ifconfig -a -u inet
    df -lh
}

function del() {
    local path
    for path in "$@"; do
        # ignore any arguments
        if [[ "$path" = -* ]]; then :
        else
            local orig=${path##*/}
            local dst=$orig
            local ver=0
            # append the time if necessary
            while [ -e ~/.Trash/"$dst" ]; do
                dst="$dst ("$((ver))")"
                ver=$((ver + 1))
            done
            mv "$path" ~/.Trash/"$dst"
        fi
    done
}

function manpdf() {
    man -t "$1"  | open -f -a  /Applications/Preview.app/
}

function mkdmg() {
    local source="$1"
    local dmg_name="$2"
    echo source = "${source}"

    # Calculate the size of the temp image file, plus a little fudge factor
    local kb=`du -d 0 -k "${source}" | cut -f1`
    local mb=`echo "(${kb} + 5000) / 1024" | bc`

    echo Creating temp image file of ${mb} Mb...
    hdiutil create -megabytes ${mb} -fs HFS+ -volname "${dmg_name}" /var/tmp/temp.dmg

    echo Mounting image...
    hdiutil mount /var/tmp/temp.dmg

    echo Copying source files...
    cp -R "${source}" "/Volumes/${dmg_name}/"

    echo Unmounting image...
    hdiutil unmount "/Volumes/${dmg_name}/"

    echo Converting image
    hdiutil convert -format UDZO /var/tmp/temp.dmg -o "${dmg_name}.dmg"

    echo Removing temp image...
    rm /var/tmp/temp.dmg
}

function gmap() {
    python -c 'import sys, webbrowser; webbrowser.open("http://maps.google.com/maps?q=%s" % ("+".join(sys.argv[1:]),))' "$@"
}


function google() {
    query=$(python -c "import sys; print('+'.join(sys.argv[1:]))" "$@")
    echo "http://www.google.com/search?q=${query}"
    open "http://www.google.com/search?q=${query}"
}

alias real='command'
alias dsclean='find . -name ".DS_Store" -exec rm {} \;'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias safari='open -a /Applications/Safari.app'
alias camerareset='sudo killall VDCAssistant'
alias sqliteui='/Applications/DB\ Browser\ for\ SQLite.app/Contents/MacOS/DB\ Browser\ for\ SQLite'
alias recipes='open https://dakrauth.com/recipes/'
alias snippets='open https://dakrauth.com/snippets/'

alias brew.deps='brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"'
alias brew.uses='brew uses --recursive --installed pango'
alias brew.xhelp='open https://dakrauth.com/snippets/da936f5c-homebrew/'

if [[ -f "${HOME}/.iterm2_shell_integration.${shell}" ]]; then
    [[ $ECHO_ON = "1" ]] && echo Loading ~/.iterm2_shell_integration.${shell}
    source "${HOME}/.iterm2_shell_integration.${shell}"
fi

export CFLAGS="-Wno-error=varargs -I$(brew --prefix)/include"
export CPPFLAGS="-I/usr/local/opt/mysql-client/include -I/usr/local/opt/openssl@1.1/include ${CPPFLAGS}"
export LDFLAGS="-L$(brew --prefix)/lib -L/usr/local/opt/mysql-client/lib ${LDFLAGS}"
export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG_PATH"
