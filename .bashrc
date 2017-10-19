# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
else
    BREW_GIT_COMPLETION=/usr/local/Cellar/git/2.*/etc/bash_completion.d/git-completion.bash

    if [ -f "$BREW_GIT_COMPLETION" ]; then
        source $BREW_GIT_COMPLETION
    fi
fi

export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/share/npm/bin

export TERM=xterm-256color
export EDITOR=vim

export PYTONDONTWRITEBYTECODE=1
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENV_USE_DISTRIBUTE=true

if [ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]; then
	source $HOME/.local/bin/virtualenvwrapper.sh
elif [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

if [ -d "/var/www/dpn_webservices" ]; then
    PYTHONPATH=/var/www/dpn_webservices:$PYTHONPATH
    export DJANGO_SETTINGS_MODULE=multidb_piston.settings
fi

export PYTHONPATH

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

source $HOME/.git-prompt.sh

alias sfix="export SSH_AUTH_SOCK=\$(find /tmp/ssh-* -user $USER -name agent\* -printf '%T@ %p\n' 2>/dev/null | sort -k 1nr | sed 's/^[^ ]* //' | head -n 1)"

install_pip() {
    curl https://bootstrap.pypa.io/get-pip.py | sudo python
}

install_rust() {
    curl -s https://static.rust-lang.org/rustup.sh | sh
}

install_dynamo_local() {
	mkdir -p $HOME/.local/bin
	mkdir -p $HOME/.local/share/dynamodb_local
	pushd $HOME/.local/share/dynamodb_local
	curl -s https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz | tar zxf -
	cat >$HOME/.local/bin/dynamodb_local <<END
#!/bin/bash
cd $HOME/.local/share/dynamodb_local/
java -jar $HOME/.local/share/dynamodb_local/DynamoDBLocal.jar
END
	chmod u+x $HOME/.local/bin/dynamodb_local
}
