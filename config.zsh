# Prevent infinite loop when Oh My Zsh sources the custom directory
if [[ "$__OMZ_RECURSION_GUARD" == "1" ]]; then
  return
fi

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

sccsh(){
    scp -r ~/.config/nvim "$1":~/.config/
    scp -r ~/.config/lazygit "$1":~/.config/
    ssh "$1"
}

alias cat="ccat"
alias less="cless"

ZSH_THEME="bira"

plugins=(
  git
  gitignore
  gh
  z
  pip
  pre-commit
  ssh
  ubuntu
  timer
  thefuck
  dirhistory
  command-not-found
  colorize
  aliases
  zsh-autosuggestions
)

TIMER_FORMAT="%d"

# Use a temporary guard so that manual 'source' from .zshrc still works
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  export __OMZ_RECURSION_GUARD=1
  source "$ZSH/oh-my-zsh.sh"
  unset __OMZ_RECURSION_GUARD
fi
