function __dft_install_topic -a topic
    # does the topic exit?
    if test -d $DFT_HOME/$topic

        # is there an installer, if so run it
        set -l installer $DFT_HOME/$topic/install.fish
        if test -f $installer
            source $installer
        end

        # persisting the topic
        __dft_persist_topic $topic
    end
end
