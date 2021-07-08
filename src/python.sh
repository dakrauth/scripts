shell=${SHELL##*/}

export PIP_REQUIRE_VIRTUALENV=true
export PYTHONWARNINGS="ignore:DEPRECATION::pip._internal.cli.base_command"
export VW_HOME=$HOME/dev/venvs

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


function __pyhelp() {
    if [[ "$shell" == "zsh" ]]; then
        alias | grep "^py\." | awk -F= '{print $1}'
    else
        alias | grep "py\." | awk -F"[ =]" '{print $2}'
    fi
}

function __pywhere() {
    python -c "import $1; print($1.__file__)"
}

function __pyclean() {
    find ${1:-$PWD} -name "*.pyc" -delete
    find ${1:-$PWD} -type d -name __pycache__ | xargs rmdir
}

function __pypath() {
    echo "$*"
    python "$*" <<EOF
import sys
args = sys.argv[1:]
print(args, end='\n\n')
if len(args) == 0:
    print('\n'.join(sys.path))
else:
    for m in args:
        try:
            mod = __import__(m)
        except ImportError:
            print("*** Could not import ", m)
        else:
            print(mod.__file__)
EOF
}

alias py.mail='sudo python -m smtpd -n -c DebuggingServer localhost:25'
alias py.serve='python -m http.server'
alias py.warn='python -Wonce'
alias py.error='python -Werror'
alias py.path='__pypath'
alias py.ack='ack --python'
alias py.m='python -m'
alias py.jt='python -m json.tool'
alias py.help='__pyhelp'
alias py.where='__pywhere'
alias py.clean='__pyclean'

function runserver() {
    if [ -z "$1" ]; then
        python manage.py runserver "localhost:8000"
    else
        python manage.py runserver "localhost:$1" 
    fi
}

alias dj.r='runserver'
alias dj.shp='python manage.py shell_plus'
alias dj.sh='python manage.py shell'
alias dj.grep='./manage.py help 2>&1 | grep'
