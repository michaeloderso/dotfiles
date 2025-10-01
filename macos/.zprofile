export SHELL_SESSIONS_DISABLE=1
export LESSHISTFILE=-

HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Commands starting with a space will not be saved in history
setopt hist_ignore_space

# Browses history only with matches based on what is already typed
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward


eval "$(/opt/homebrew/bin/brew shellenv)"


# remove ~/.DS_Store if exists (fzf and eza have issues ignoring ~/.DS_Store even if globally ignored)
[ -f ~/.DS_Store ] && rm ~/.DS_Store