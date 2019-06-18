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

export EDITOR=vim
alias vi=nvim
alias vim=nvim

export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/share/npm/bin
export TERM=xterm-256color

export PS1=$'\n\[\e[48;5;237;38;5;1m\]\u@\h \[\e[48;5;239;38;5;237m\]\ue0b0\[\e[38;5;6m\] \ue0a0 $(__git_ps1) \[\e[48;5;235;38;5;239m\]\ue0b0\[\e[38;5;3m\] ($(pyenv version-name)) \w \[\e[38;5;235;49m\]\ue0b0\n\[\e[0m\]\$ \[$(tput sgr0)\]'
source $HOME/.git-prompt.sh

alias sfix="export SSH_AUTH_SOCK=\$(find /tmp/ssh-* -user $USER -name agent\* -printf '%T@ %p\n' 2>/dev/null | sort -k 1nr | sed 's/^[^ ]* //' | head -n 1)"

install_pip() {
    curl https://bootstrap.pypa.io/get-pip.py -sSf | sudo python
}

install_rust() {
    curl https://sh.rustup.rs -sSf | sh $*
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

export GOPATH=$HOME/src/go
export PATH=$PATH:$HOME/.local/go/bin:$HOME/src/go/bin

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

source $HOME/.bashrc_python
