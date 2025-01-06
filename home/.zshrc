### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### Helpers
IS_VSCODE=false
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    IS_VSCODE=true
fi

### Zsh Configuration
setopt promptsubst
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} "

### Zstyle
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':omz:plugins:eza' 'dirs-first' yes
if ! $IS_VSCODE; then
    zstyle ':omz:plugins:eza' 'hyperlink' yes
fi

### Env
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export GPG_TTY=$(tty)
export PATH="$HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH="$PATH:/Users/brian/.local/bin"
export PATH="$PATH:/Users/brian/.cargo/bin"
export PATH="$PATH:/Users/brian/.cargo/bin"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export NEXTTRACE_DATAPROVIDER=ipinfo
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

### OMZ
# zi snippet OMZL::async_prompt.zsh
# zi snippet OMZL::directories.zsh
# zi snippet OMZT::robbyrussell
zi wait lucid light-mode for \
    OMZL::theme-and-appearance.zsh \
    OMZL::key-bindings.zsh \
    OMZL::clipboard.zsh \
    OMZL::history.zsh \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::history \
    OMZP::eza \
    OMZP::extract \
    OMZP::git-commit \
    OMZP::rust \
    OMZP::copyfile

zi ice wait as"completion" for \
    OMZP::docker/completions/_docker \
    OMZP::docker-compose/_docker-compose

#### Plugins
# custom lazy snippets
zi ice wait lucid
zi snippet ~/.lazy.zsh

# online plugins
zi wait lucid light-mode depth"1" for \
    Aloxaf/fzf-tab \
    orbstack/orbstack \
    ajeetdsouza/zoxide

# starship
if $IS_VSCODE; then
    # vsocde has _precmd and _preexec hooks conflict with starship if we use async
    zinit ice lucid as"command" from"gh-r" \
                atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
                atpull"%atclone" src"init.zsh"
else
    zinit ice wait lucid as"command" from"gh-r" \
                atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
                atpull"%atclone" src"init.zsh"
fi
zinit light starship/starship

### Custom Functions
# git last commit date edit
function git-amend-date() {
  local date=$1
  GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit --amend --no-edit --date="$date" --no-verify
}

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# dog (doggo with surge)
DOG_SURGE_DNS="198.18.0.2"
DOG_DEFAULT_DNS="https://dns.alidns.com/dns-query"
function dog() {
    # Check if has spec dns server
    if [[ "$@" == *@* ]]; then
        doggo "$@"
    else
        # Get systen DNS from /etc/resolv.conf
        current_dns=$(cat /etc/resolv.conf | grep '^nameserver' | awk '{print $2}' | head -n 1)
        # Not Surge DNS
        if [ "$current_dns" != "$DOG_SURGE_DNS" ]; then
            doggo "$@"
        else
            # Is Surge DNS, use dog default dns
            doggo "$@" @"$DOG_DEFAULT_DNS"
        fi
    fi
}

# check if using correct cargo
function check_cargo() {
  cargo_path=$(which cargo 2>/dev/null)
  if [[ -z "$cargo_path" ]]; then
    echo "Cargo is not installed or not in PATH."
    return 1
  fi
  if [[ "$cargo_path" == "/opt/homebrew/bin/cargo" ]]; then
    echo "$cargo_path cargo path error"
  fi
}

### Completion
zi wait lucid light-mode depth"1" for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zsh-users/zsh-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions

### Aliases
# alias ls="lsd --icon=never"
# alias ls="eza"
