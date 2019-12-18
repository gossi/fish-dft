function __dft_uninstall_topic -a topic
    # run uninstaller
    set -l uninstaller $DFT_HOME/$topic/uninstall.fish
    if test -f $uninstaller
        source $uninstaller
    end

    # remove from dftfile
    set topics (cat $DFTFILE)

    # erase file
    true >$DFTFILE

    for t in $topics
        if test $t != $topic
            __dft_persist_topic $t
        end
    end
end