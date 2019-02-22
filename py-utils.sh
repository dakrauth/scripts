alias py.mail='sudo python -m smtpd -n -c DebuggingServer localhost:25'
alias py.serve='python -m http.server'
alias py.warn='python -Wonce'
alias py.error='python -Werror'
alias py.help='alias | grep "^alias py"'
alias py.path='python -c "import sys; print(\"\n\".join(sys.path))"'
alias py.ack='ack --python'
alias py.m='python -m'
alias py.jt='python -m json.tool'

function py.where() {
    python -c "import $1; print $1.__file__"
}

function py.clean() {
    find ${1:-$PWD} -name "*.pyc" -delete
    find ${1:-$PWD} -type d -name __pycache__ | xargs rmdir
}

alias dj.shp='python manage.py shell_plus'
alias dj.sh='python manage.py shell'
alias dj.grep='./manage.py help 2>&1 | grep'
