# See README.md

export LSCOLORS="GxFxdadxDxegedabagAcad"

alias dsclean='find . -name ".DS_Store" -exec rm {} \;'
alias pf='open -a "/Applications/Path Finder.app"'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias utcnow='python -c "import datetime;print(datetime.datetime.utcnow())"'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias safari='open -a /Applications/Safari.app'
alias camerareset='sudo killall VDCAssistant'

function vts2iso() {
    discname=`basename "${1%.*}"`
    echo "$discname"
    hdiutil makehybrid -udf -udf-volume-name "$discname" -o "$discname".iso "$1"
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

