function __dft_install_all
    if test -f $DFTFILE
        set topics (cat $DFTFILE)
        for topic in $topics
            __dft_install_topic $topic
        end
    end
end