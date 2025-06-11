
export EDITOR="vscodium"

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"

    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
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

alias reloadwaybar="pkill waybar && waybar & disown"
alias vim="nvim"

