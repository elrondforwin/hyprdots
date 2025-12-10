function fish_greeting
end

# init zoxide if found
if type -q zoxide
    zoxide init fish | source
    alias cd="z"
end

# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function bak --argument filename
    cp $filename $filename.bak
end

# Replace ls with eza if available
if type -q eza
    alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons' # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | grep -e '^\.'" # show only dotfiles
end

if type -q ncdu
    alias disk='ncdu'
end

if type -q fzf
    fzf --fish | source
end

# aliases
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
if type -q nvim
    alias vim="nvim"
    alias vi="vim"
    alias v="vim"
end

if type -q code
    alias code="code --enable-features=UseOzonePlatform --ozone-platform=wayland"
    alias code-oss="code --enable-features=UseOzonePlatform --ozone-platform=wayland"
end

if type -q code-oss
    alias code="code-oss --enable-features=UseOzonePlatform --ozone-platform=wayland"
    alias code-oss="code-oss --enable-features=UseOzonePlatform --ozone-platform=wayland"
end
if type -q waybar
    alias reloadwaybar="pkill waybar && waybar & disown"
end

# Get fastest mirrors with reflector
if type -q reflector
    alias mirror="sudo reflector --verbose -l 50 -n 10 -p http --sort rate --save /etc/pacman.d/mirrorlist"
else
    alias mirror="echo 'Please install reflector first.'"
end

# Recent installed packages
if type -q expac
    alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
end

if type -q Hyprland
    if not test -f /tmp/hyprland.lock
        touch /tmp/hyprland.lock
        exec Hyprland
    end
end

# prompt
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brpurple)
    set -l cwd_color (set_color blue)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo ' '
    echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end

# yazi init
if type -q yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"

        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

# nemo here
if type -q nemo
    alias nemohere="nemo . 2&> /dev/null & disown"
end

if type -q rmpc
    alias r="rmpc"
end

function cevirmov
    if test (count $argv) -ne 2
        echo "Kullanım: cevirmov input.mp4 output.mov"
        return 1
    end

    set input "$argv[1]"
    set output "$argv[2]"

    ffmpeg -i "$input" -c:v copy -c:a pcm_s16le -ar 48000 "$output"
end

function cevirmp4
    if test (count $argv) -ne 2
        echo "Kullanım: cevirmp4 input.mov/mkv/mp4 output.mp4"
        return 1
    end

    set input "$argv[1]"
    set output "$argv[2]"

    ffmpeg -i "$input" -vcodec libx265 -crf 28 "$output"
end

cat ~/.local/state/caelestia/sequences.txt 2>/dev/null
