function cevir
    if test (count $argv) -ne 2
        echo "Kullanım: cevir input.mp4 output.mp4"
        return 1
    end

    ffmpeg -i $argv[1] -vcodec libx265 -crf 28 $argv[2]
end