# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Flatpak desktop integration fix
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/elrond/.local/share/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

# add ~/.local/bin to $PATH
PATH=$PATH:/$HOME/.local/bin

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

OMP_THEMES_PATH="/$HOME/.config/oh-my-posh"
OMP_THEME="$OMP_THEMES_PATH/zen.toml"

# load oh my posh if found
if [[ ! -z $(command -v oh-my-posh) ]]; then
    eval "$(oh-my-posh init zsh -c $OMP_THEME)"
    if [[ ! -f $OMP_THEME ]]; then
      mkdir -p $OMP_THEMES_PATH
      curl -fsSL "https://raw.githubusercontent.com/dreamsofautonomy/zen-omp/refs/heads/main/zen.toml" -o $OMP_THEME
    fi
  else
    echo "oh-my-posh not found in PATH!"
    if [[ ! -f /$HOME/.local/bin/oh-my-posh ]]; then
      echo "Installing oh-my-posh to ''~/.local/bin'"
      curl -s https://ohmyposh.dev/install.sh | bash -s
    else
      echo "oh-my-posh is present, but not in PATH."
    fi
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias update='sudo pacman -Syu'
alias img="kitten icat"
alias copy="wl-copy"
alias jctl="journalctl -p 3 -xb"

# some movement fixes
bindkey '\e[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Shell integrations and some aliases
if command -v fzf > /dev/null; then
    eval "$(fzf --zsh)"
fi

if command -v zoxide > /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

if command -v eza > /dev/null; then
    alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons' # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | grep -e '^\.'" # show only dotfiles
fi

if command -v ncdu > /dev/null; then
    alias disk='ncdu'
fi

if command -v nvim > /dev/null; then
    alias vim="nvim"
    alias vi="vim"
    alias v="vim"
fi

if command -v code > /dev/null; then
    alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"
    alias code-oss="code --enable-features=UseOzonePlatform --ozone-platform=wayland"
fi

if command -v rmpc > /dev/null; then
    alias r="rmpc"
fi

if command -v yazi > /dev/null; then
    function y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      yazi "$@" --cwd-file="$tmp"
      IFS= read -r -d '' cwd < "$tmp"
      [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
      rm -f -- "$tmp"
    }
fi

if command -v waybarctl > /dev/null; then
    alias reloadwaybar="waybarctl reload"
fi

if command -v reflector > /dev/null; then
    alias mirror="sudo reflector --verbose -l 50 -n 10 -p http --sort rate --save /etc/pacman.d/mirrorlist"
else
    alias mirror="echo 'Please install reflector first.'"
fi

if command -v expac > /dev/null; then
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
fi

if command -v nemo > /dev/null; then
    alias nemohere="nemo . &> /dev/null & disown"
fi

if command -v Hyprland > /dev/null; then
  if [[ ! -f /tmp/hyprland.lock ]]; then
    touch /tmp/hyprland.lock
    Hyprland
  fi
fi


