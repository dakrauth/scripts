#!/bin/bash
#set -e

function whatvenv() {
    if [ $VIRTUAL_ENV ]; then
        echo VIRTUAL_ENV = $VIRTUAL_ENV
    else
        echo VIRTUAL_ENV Not Set
    fi
}

function wherevenv() {
    local where="$1"
    if [[ ${where} =~ "/" ]]; then
        echo $(python -c "import os,sys;print(os.path.abspath(sys.argv[1]))" "${where}")
    else
        echo "$VW_HOME/$where"
    fi
}

function showvenvs() {
    local ver=""
    for name in $VW_HOME/*; do
        if [[ -d $name && -e $name/bin/python ]]; then
            ver=`$name/bin/python -V 2>&1`
            echo "$(basename $name) ($ver)"
        fi
    done
}

function mkvenv() {
    local name="$1"
    local pyver=$(python -V 2>&1 | cut -d" " -f 2)
    if [ -z $name ]; then
        showvenvs
        return 0
    else
        local fullpath="$(wherevenv $name)"
        if [ $VIRTUAL_ENV ]; then
            echo Deactivating: "$VIRTUAL_ENV"
            deactivate 2>&1 > /dev/null
        fi

        if [ -d $fullpath ]; then
            echo "Found $fullpath"
        else
            if [[ $pyver == 2* ]]; then
                echo "Creating venv $fullpath with Python 2 (using virtualenv)"
                virtualenv $fullpath
            else
                echo "Creating venv $fullpath with Python 3 (using python -m venv)"
                python -m venv $fullpath
            fi
        fi
        echo Activating "$fullpath"
        source "$fullpath/bin/activate"
    fi
}

function cdvenv() {
    pushd "$VIRTUAL_ENV/$1"
}

function rmvenv () {
    for arg in $*; do
        local where="$(wherevenv $arg)"
        if [ "$where" != "/" ]; then
            if [ "$where" = "$VIRTUAL_ENV" ]; then
                deactivate 2>&1 > /dev/null
            fi
            echo Removing $where
            rm -rf "$where"
        fi
    done
}

function lsvenv() {
    local location=($VIRTUAL_ENV/$1)
    if [ $VIRTUAL_ENV ]; then
        echo "Listing $location"
        ls -Al "$location"
    else
        echo "Virtual env not activated"
    fi
}

alias vw='mkvenv'
alias vw.help='alias | grep "^alias vw"'
alias vw.x='deactivate'
alias vw.rm='rmvenv'
alias vw.cd='cdvenv'
alias vw.cds='cdvenv lib/python*/site-packages'
alias vw.cdsrc='cdvenv src'
alias vw.cdb='cdvenv bin'
alias vw.ls='lsvenv lib/python*/site-packages'
alias vw.lss='lsvenv src'
alias vw.lsb='lsvenv bin'
alias vw.alias='alias | grep "^alias vw"'
alias vw.what='whatvenv'

