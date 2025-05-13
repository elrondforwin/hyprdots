function cevirmp4
    if test (count $argv) -ne 2
        echo "Kullanım: cevirmp4 input.mov/mkv/mp4 output.mp4"
        return 1
    end

    set input "$argv[1]"
    set output "$argv[2]"

    ffmpeg -i "$input" -vcodec libx265 -crf 28 "$output"
end
