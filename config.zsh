# Prevent infinite loop when Oh My Zsh sources the custom directory
if [[ "$__OMZ_RECURSION_GUARD" == "1" ]]; then
  return
fi

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

alias cat="ccat"

alias rhps1t="ssh rhps1user@rhps1t.s.aist.go.jp"
alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

# alias hrp5pt="ssh hrp5puser@hrp5pt.s.aist.go.jp"
# alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
# alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

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
