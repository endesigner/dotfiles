[[ -s "$HOME/.bin/vim-bundle" ]] && PATH=$PATH:$HOME/.bin
[[ -s "/opt/local/bin" ]] && PATH=$PATH:/opt/local/bin
eval "$(rbenv init -)"

export EDITOR=nvim
export VISUAL=nvim
#export PAGER='nvim -R -u ~/.config/nvim/init.vim -'

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

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

bindkey '^R' history-incremental-search-backward

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
    if [[ -a ".ruby-version" ]]; then
        RUBY_VERSION="%{$fg[green]%}$(rbenv local)%{$reset_color%}"
    else
        RUBY_VERSION=""
    fi

    export RPROMPT="$(git_super_status) $RUBY_VERSION"
    export PROMPT="${VIMODE} %~ "
}

alias tmux='TERM=xterm-256color tmux'
setopt complete_in_word         # Not just at the end
setopt always_to_end            # When complete from middle, move cursor

source ~/.zsh/zshalias

export NVM_DIR="/Users/igor/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

PATH="/Users/igor/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/igor/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/igor/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/igor/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/igor/perl5"; export PERL_MM_OPT;
