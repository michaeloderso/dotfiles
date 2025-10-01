# Required packages: fzf fd bat eza
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='fd --strip-cwd-prefix --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="
  --preview 'if [ -d {} ]; then tree -C {} | head -200; else bat --style=numbers --color=always --line-range :200 {}; fi'
  --preview-window=right:60%
"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow . "$1"
}