# Prevent infinite loop if sourced by Oh My Zsh from custom directory
if [[ -z "$CONFIG_ZSH_LOADED" ]]; then
  export CONFIG_ZSH_LOADED=1

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
    ubuntu
    timer
    thefuck
    dirhistory
    command-not-found
    colorize
    aliases
  )

  TIMER_FORMAT="%d"

  # Only source OMZ if it hasn't been sourced yet
  if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
  fi
fi

# Content here will run even when sourced by OMZ
# (though currently we have everything inside the guard)
