# If not running interactively, don't do anything
# vim: set ts=2 sw=2 expandtab:

[ -z "$PS1" ] && return

if [ -d $HOME/.linuxbrew ]; then
	eval $($HOME/.linuxbrew/bin/brew shellenv)
else
	if [ -f /opt/homebrew/bin/brew ]; then
		eval $(/opt/homebrew/bin/brew shellenv)
	fi
fi
# DO THIS WAY UP TOP SO IT CAN BE OVERWRITTEN
if [ -f $HOME/.linuxify ]; then
	. "$HOME/.linuxify"
fi

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

if [ $(command -v exa) ]; then
	alias ls='exa --icons --binary -l --git'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
else
	BREW_GIT_COMPLETION=/usr/local/Cellar/git/2.*/etc/bash_completion.d/git-completion.bash

	if [ -f "$BREW_GIT_COMPLETION" ]; then
		source $BREW_GIT_COMPLETION
	fi
fi

export EDITOR=nvim
alias vi=nvim
alias vim=nvim

export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/share/npm/bin
source $HOME/.git-prompt.sh
source $HOME/.bashrc_python
source ~/.prompt.sh

tmux-cwd() {
	tmux command-prompt -I $PWD -p "New working directory: " "attach -c %1"
}

alias sfix="export SSH_AUTH_SOCK=\$(find /tmp/ssh-* -user $USER -name agent\* -printf '%T@ %p\n' 2>/dev/null | sort -k 1nr | sed 's/^[^ ]* //' | head -n 1)"

install_pip() {
	curl https://bootstrap.pypa.io/get-pip.py -sSf | sudo python
}

install_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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

install_neovim() {
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o $HOME/.local/bin/nvim
	chmod u+x $HOME/.local/bin/nvim
}

export HELM_HOME=$HOME/src/helm

export GOPATH=$HOME/src/go
export PATH=$PATH:$HOME/.local/go/bin:$HOME/src/go/bin

if [ $(command -v kubectl) ]; then
	source <(kubectl completion bash)
fi

if [ $(command -v helm) ]; then
	source <(helm completion bash)
fi

if [ $(command -v argo) ]; then
	source <(argo completion bash)
fi

if [ $(command -v pyenv) ]; then
	eval "$(pyenv init -)"
	if which pyenv-virtualenv-init >/dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi

#if [ -f $HOME/.cargo/env ]; then
#  source $HOME/.cargo/env
#fi

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if [ $(command -v fnm) ]; then
	eval "$(fnm env --use-on-cd)"
fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f $HOME/.local_bashrc ]; then
	source $HOME/.local_bashrc
fi

export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
