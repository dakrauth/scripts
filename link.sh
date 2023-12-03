#!/usr/bin/env bash

readonly homeDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -P )/home"
echo homeDir="${homeDir}"
echo ====================


for src in $(find $homeDir); do
    if [[ "${src}" = "${homeDir}" || $(basename $src) = .DS_Store ]]; then
        echo Skipping $src
        continue
    fi
    dest=$HOME${src/${homeDir}/}
    if [[ -e "$dest" ]]; then
        echo Destination $dest exists, skipping
    else
        echo dest = $dest
        if [[ -d "$src" ]]; then
            echo mkdir -pv "$dest"
            mkdir -pv "$dest"
        else
            if [[ $(basename $src) != .DS_Store ]]; then
                echo ln -s $src $dest
                ln -s $src $dest
            fi
        fi
    fi
    echo
done


