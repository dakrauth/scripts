function ssh_forward() {
    ssh -N $1 -L 8778:127.0.0.1:3306

function mcd() { 
    mkdir -p "$@" && cd "${1}" 
}

function manpdf() {
    man -t "$1"  | open -f -a  /Applications/Preview.app/
}

function mantext() {
    man "$1"  | col -bx
}

function calc() { 
    echo "${1}"|bc -l 
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

function md() {
    local fname
    for fname in "$@"; do
        echo "${fname} --> ${fname%.*}.html"
        markdown "$fname" > "${fname%.*}.html"
    done
}

function scsswatch() {
    echo Watching "${1}:${1%.*}.css"
    scss --watch "${1}:${1%.*}.css"
}

function swapext() {
    local ext="$1"
    shift
    for orig in "$@"
    do
        echo "$orig ==> " "${orig%.*}.${ext}"
        mv "$orig" "${orig%.*}.${ext}"
    done
}

function tbz () {
    tar cvjf "$1".tbz "$1"
}

function runserver() {
    if [ -z "$1" ]; then
        python manage.py runserver "localhost:8000"
    else
        python manage.py runserver "localhost:$1" 
    fi
}

function git_killtag () {
    git tag -d "$1" && git push --delete origin "$1"
}

function google() {
    query=$(python -c "import sys; print('+'.join(sys.argv[1:]))" "$@")
    echo "http://www.google.com/search?q=${query}"
    open "http://www.google.com/search?q=${query}"
}

function vts2iso() {
    discname=`basename "${1%.*}"`
    echo "$discname"
    hdiutil makehybrid -udf -udf-volume-name "$discname" -o "$discname".iso "$1"
}

function whatport() {
    lsof -i :$1
}
