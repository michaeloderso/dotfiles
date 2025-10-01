function newproj {
    location=$HOME/Repositories/_sandbox/$1

    mkdir $location &&
    echo "Successfully created new sandbox $1" &&
    
    cd $location &&
    echo "Current working directory: $location" 
}


function create_github_repo {

    github_username="lilacred"


    repo_name=$(basename $PWD)

    if [[ -n "$1" ]]; then
        repo_name=$1
    fi


    gh repo create $repo_name --private
    status=$?

    if [ $status -eq 0 ]; then

        if [ ! -d .git ]; then
            git init
        fi

        git add .
        git commit -m "init"

        git remote add origin git@github.com:$github_username/$repo_name.git
        
        git branch -M main
        git push -u origin main

    fi
}


# bindkey -e => Selects keymap ‘emacs’ for any operations by the current command, and also links ‘emacs’ to ‘main’ so that it is selected by default the next time the editor starts.
# bindkey -v => Selects keymap ‘viins’ for any operations by the current command, and also links ‘viins’ to ‘main’ so that it is selected by default the next time the editor starts.
# bindkey -a => Selects keymap ‘vicmd’ for any operations by the current command.
# viopp, visual ?

function show_vi_keybinds() {
    bindkey -M viins
}

function show_if_set() {
    looking_for=$(zle -al | fzf)
    is_set=$(bindkey | grep $looking_for)

    if [[ -n "$is_set" ]]; then
        echo "keymap is set"
        echo $is_set
    else
        echo "keymap not set"
    fi
}

function show_if_already_used() {
    if [[ $1 != "q" ]]; then # give an argument "q" (for "quiet") to skip showing the info
        echo "info: use uppercase letters to search for the keybind!"
        sleep 1
    fi

    bindkey | fzf
}


function setup_nvchad() {
    # check if ripgrep is installed
    rm -rf ~/.config/nvim & rm -rf ~/.local/state/nvim & rm -rf ~/.local/share/nvim & rm -rf ~/.cache/nvim
    git clone https://github.com/NvChad/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git
    # nvim
}

function reset_nvchad() {
    rm -rf ~/.config/nvim &
    rm -rf ~/.local/state/nvim &
    rm -rf ~/.local/share/nvim &
    rm -rf ~/.cache/nvim &
    rm -rf ~/.config/nvim/.git
    nvim
}

function setup_nerd_fonts() {
    nerd_fonts=(
        font-jetbrains-mono-nerd-font
        font-sauce-code-pro-nerd-font
        font-fira-mono-nerd-font
        font-fira-code-nerd-font
    )

    # brew tap homebrew/cask-fonts

    for font in "${nerd_fonts[@]}"
    do
    brew install --cask "$font"
    done
}



alias r="cd $HOME/Repositories"

alias np="newproj"
alias cr="create_github_repo"

alias hst="cat $HOME/.zsh_history | fzf"

################################################################################################

export RUSTUP_HOME=$HOME/.local/share/rust/rustup
export CARGO_HOME=$HOME/.local/share/rust/cargo
. $CARGO_HOME/env


. "$HOME/.local/bin/env" # uv cli
# bun completions
[ -s "/Users/Michael/.bun/_bun" ] && source "/Users/Michael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"