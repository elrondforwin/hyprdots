function cevirmov
    if test (count $argv) -ne 2
        echo "Kullanım: cevirmov input.mp4 output.mov"
        return 1
    end

    set input "$argv[1]"
    set output "$argv[2]"

    ffmpeg -i "$input" -c:v copy -c:a pcm_s16le -ar 48000 "$output"
end
