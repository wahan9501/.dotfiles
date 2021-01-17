#================================ Envrionment variables ================================#
export EDITOR="nvim"
export ZSHDIR="$HOME/.zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export KEYTIMEOUT=1
export win="/mnt/c/Users/"

#================================ ZSH ================================#
# History in cache directory:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$ZSHDIR/.zsh_history
setopt INC_APPEND_HISTORY_TIME
mkdir -p ~/.zsh

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# inline bash-style comments
setopt interactive_comments
stty stop undef     # Disable ctrl-s to freeze terminal.

# zsh plugin manager antigen
if [ -z "~/.zsh/antigen.zsh" ]
then
    echo antigen not installed
    echo install antigen...
    curl -L git.io/antigen > ~/.zsh/antigen.zsh
    echo antigen installed
fi

source ~/.zsh/antigen.zsh
# zsh plugins
# antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# set the suggestion strategy of zsh plugin autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history)

# setup PS1
autoload -U colors && colors    # Load colors
## Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'

setopt prompt_subst
PS1='%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[green]%}${vcs_info_msg_0_} %{$reset_color%}%%%b '

##================================ Color ================================#
## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#================================ Key binding ================================#
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey "^e"        edit-command-line
bindkey "^[[H"      beginning-of-line
bindkey "^[[F"      end-of-line
bindkey "^H"        backward-kill-word
bindkey "^[[3;5~"   kill-word
bindkey "^[[1;5D"   backward-word
bindkey "^[[1;5C"   forward-word
bindkey "^[[3~"     delete-char
bindkey "^[[Z"      reverse-menu-complete
#bindkey "^r"        history-incremental-search-backward
bindkey "^N"        autosuggest-accept
bindkey -s "^[\\"   "clear && source ~/.zshrc^M"

#================================ Alias ================================#
# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vivimrc='nvim $XDG_CONFIG_HOME/nvim/init.vim'
alias vizrc='nvim ~/.zshrc'
alias vitmuxrc='nvim ~/.tmux.conf'
alias magit="nvim -c MagitOnly"
alias gitinit="git config user.email wahan9501@gmail.com && git config user.name han"

alias :q='exit'

##================================ Welcome message ================================#
#echo '=============================='
#echo $(date)
#echo '=============================='
#echo
#echo 'Welcome back' ':P'

#================================ Command ================================#
export roll() {
    shuf -i 1-6 -n 1
}

export tgc() {
    if [ -z `which tmux` ]
    then
        echo tmux not installed
    else
        tmux split-window -h "git commit"
    fi
}

#================================ Navi ================================#
which navi > /dev/null
if [ $? -eq 0 ]
then
    export NAVI_FZF_OVERRIDES="--height 20%" navi
    export FZF_DEFAULT_COMMAND='find .'
    eval "$(navi widget zsh)"
fi

#================================ FZF ================================#
which fzf > /dev/null
if [ $? -eq 0 ]
then
    if test -e /usr/share/fzf/key-bindings.zsh && test -e /usr/share/fzf/completion.zsh
    then
        source /usr/share/fzf/key-bindings.zsh
        source /usr/share/fzf/completion.zsh
    fi
    if test -e /usr/share/doc/fzf/examples/key-bindings.zsh && test -e /usr/share/doc/fzf/examples/completion.zsh
    then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
        source /usr/share/doc/fzf/examples/completion.zsh
    fi
fi

#================================ TMUX ================================#
which tmux > /dev/null
if [ $? -eq 0 ]
then
    local main_attached="$(tmux list-sessions -F '#S #{session_attached}' \
            2>/dev/null \
                | sed -n 's/^main[[:space:]]//p')"
    if [[ "$main_attached" -le '0'  ]] && [[ "$TERM" != 'linux'  ]]; then
            tmux new -A -s main >/dev/null 2>&1
                exit
    fi
fi

neofetch
