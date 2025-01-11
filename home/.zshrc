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

### OMZ
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

#### Snippets & Plugins
zi ice wait'0' lucid light-mode blockf multisrc'~/.config/zinit/{env,func,active,alias}.zsh'
zi light z-shell/null

# online plugins
zi wait lucid light-mode depth"1" blockf for \
    Aloxaf/fzf-tab \
    orbstack/orbstack \
    ajeetdsouza/zoxide

# starship
if $IS_VSCODE; then
    # vsocde has _precmd and _preexec hooks conflict with starship if we use async
    zi ice lucid as"command" from"gh-r" \
        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh"
else
    zi ice wait lucid as"command" from"gh-r" \
        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh"
fi
zi light starship/starship

### Completion
zi wait lucid light-mode as"completion" for \
    OMZP::docker/completions/_docker \
    OMZP::docker-compose/_docker-compose \
    https://raw.githubusercontent.com/sharkdp/fd/master/contrib/completion/_fd \
    id-as"_rg" \
        https://raw.githubusercontent.com/BurntSushi/ripgrep/master/crates/core/flags/complete/rg.zsh

zi wait lucid light-mode depth"1" for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zsh-users/zsh-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions
