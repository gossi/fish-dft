function __dft_update -d 'update'
    brew update
    brew upgrade

    if test -f $DFTFILE
        set topics (cat $DFTFILE)
        for topic in $topics
            set -l updater $DFT_HOME/$topic/update.fish
            if test -f $updater
                source $updater
            end
        end
    end
end
