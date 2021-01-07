#================================ Envrionment variables ================================#
export EDITOR="nvim"
export ZSHDIR="$HOME/.zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export KEYTIMEOUT=1
export winuser="/mnt/c/Users/"

#================================ ZSH ================================#
# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$ZSHDIR/history

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
source /usr/share/zsh/share/antigen.zsh
# zsh plugins
antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

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

bindkey -s "^[\\"   "clear && source ~/.zshrc^M"

#================================ Alias ================================#
# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vimrc='nvim $XDG_CONFIG_HOME/nvim/init.vim'
alias vizrc='nvim ~/.zshrc'
alias magit="nvim -c MagitOnly"
alias gitinit="git config user.email wahan9501@gmail.com && git config user.name han"

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

#================================ Navi ================================#
export NAVI_FZF_OVERRIDES="--height 20%" navi
export FZF_DEFAULT_COMMAND='find .'
eval "$(navi widget zsh)"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

neofetch
