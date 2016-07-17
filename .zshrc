[[ -s "$HOME/.bin/vim-bundle" ]] && PATH=$PATH:$HOME/.bin
[[ -s "/opt/local/bin" ]] && PATH=$PATH:/opt/local/bin
EDITOR=vi

export SAVEHIST=10000 # Number of entries
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immidiatly
setopt HIST_FIND_NO_DUPS # Don't show duplicates in search
setopt HIST_IGNORE_SPACE # Don't preserve spaces. You may want to turn it off
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals

# Vi style keys
set -o vi
autoload -U         edit-command-line
zle -N              edit-command-line
bindkey -M vicmd v  edit-command-line

# Display Vi input mode in the prompt line
VIMODE=[i]
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
    PROMPT="${VIMODE} %~ "
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


autoload -U compinit && compinit
autoload -U colors && colors
fpath=(~/.zsh/Completion $fpath)
source ~/.zsh/zshrc.sh
precmd () {
    if [[ -a ".rvmrc" ]]; then
        RVMINFO="%{$fg[green]%}$(rvm current)%{$reset_color%}"
    else
        RVMINFO=""
    fi

    export RPROMPT="$(git_super_status) $RVMINFO"
    export PROMPT="${VIMODE} %~ "
}

alias tmux='TERM=xterm-256color tmux'
alias vi='/usr/local/Cellar/macvim/7.3-66/MacVim.app/Contents/MacOS/Vim'
setopt complete_in_word         # Not just at the end
setopt always_to_end            # When complete from middle, move cursor

func () {
    myvar=($(ls ~/**/.rvmrc))
    mypwd=$(pwd)
    print "pwd: $mypwd"
    #print "${myvar[(r)^'${mypwd}'*]}"
    pat="^'${mypwd}'*"

    for el in $myvar; do
        if [[ ${myvar[(r)$pat]} -le ${#myvar} ]]; then
            print "Found: ${myvar[(r)$pat]}"
        fi
    done
}
func2 () {
    myvar=($(ls ~/**/.rvmrc))
    mypwd=$(pwd)
    for el in $myvar; do
        if [[ $el == "${mypwd}/.rvmrc" ]]; then
            print "$el is $mypwd"
        fi
    done
}
source ~/.zsh/zshalias
