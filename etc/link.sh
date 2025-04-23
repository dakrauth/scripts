#!/usr/bin/env bash

function link() {
    if [[ -z "$1" ]]; then
        echo Missing source directory
        return
    fi

    for src in $(find "$1" -depth 1); do
        src_name=$(basename $src)
        if [[ "$src_name" = .DS_Store  ]]; then
            continue
        fi
        dest=$HOME/${src_name}
        if [[ -e "$dest" ]]; then
            echo "!!!" Destination $dest exists, skipping
            continue
        fi
        ln -s "$src" "$HOME/$src_name"
    done
}

link "$1"
