### Environment variables

export GPG_TTY=$(tty)

export PATH="$HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH="$PATH:/Users/brian/.local/bin"
export PATH="$PATH:/Users/brian/.cargo/bin"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export NEXTTRACE_DATAPROVIDER=ipinfo
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
