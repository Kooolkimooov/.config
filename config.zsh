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

alias rhps1t="ssh rhps1user@rhps1t.s.aist.go.jp"
alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

# alias hrp5pt="ssh hrp5puser@hrp5pt.s.aist.go.jp"
# alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
# alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

agents() {
  local name="${PWD:t}"
  name="${name//[.:]/-}"   # tmux disallows . and : in session names

  if tmux has-session -t "=$name" 2>/dev/null; then
    tmux attach -t "=$name"
    return
  fi

  tmux new-session  -d -s "$name" -n claude -c "$PWD" claude
  tmux new-window      -t "=$name" -n codex  -c "$PWD" codex
  tmux select-window -t "=$name:claude"
  tmux attach -t "=$name"
}

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
