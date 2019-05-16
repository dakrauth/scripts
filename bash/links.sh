function __makelink() {
    local src=$1
    local dst=$2

    echo "Linking ${src} => ${dst}"
    if [ -e ${dst} ]; then
        if [ -L ${dst} ]; then
            echo "    Overriding existing symlink"
            rm ${dst}
            ln -s ${src} ${dst}
        elif [ -f ${dst} ]; then
            echo "    It is a regular file. Skipping!"
        fi
    else
        ln -s ${src} ${dst}
    fi

}

function linkdots() {
    local dot
    for dot in $SCRIPTS_PATH/dotfiles/*; do
        local dest=$HOME/."$(basename ${dot})"
        __makelink "${dot}" "${dest}"
    done
}

function linkbins() {
    local bin
    mkdir -p ~/bin
    for bin in $SCRIPTS_PATH/bin/*; do
        local dest=$HOME/bin/"$(basename ${bin})"
        __makelink "${bin}" "${dest}"
    done
}

