function play
    set tmp (mktemp -t "play-cwd.XXXXXX")
    play-engine --cwd-file "$tmp" $argv
    set rc $status
    if test -s "$tmp"
        set cwd (cat "$tmp")
        if test -d "$cwd"
            cd "$cwd"
        end
    end
    rm -f "$tmp"
    return $rc
end
