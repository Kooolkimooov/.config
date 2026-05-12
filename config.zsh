[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

alias cat="ccat"

alias rhps1t="ssh rhps1user@rhps1t.s.aist.go.jp"
alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

# alias hrp5pt="ssh hrp5puser@hrp5pt.s.aist.go.jp"
# alias rhps1c="ssh rhps1user@rhps1c.s.aist.go.jp"
# alias rhps1v="ssh rhps1user@rhps1v.s.aist.go.jp"

eval $(thefuck --alias)

ZSH_THEME="bira"

plugins=(git gitignore gh)
plugins+=(z ubuntu timer thefuck)
plugins+=(dirhistory command-not-found colorize aliases)

































