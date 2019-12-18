function __dft_persist_topic -a topic
    if not grep -qF "$topic" $DFTFILE
        echo $topic >>$DFTFILE
    end
end