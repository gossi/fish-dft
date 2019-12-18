function __dft_install_topic -a topic
    set -l installer $DFT_HOME/$topic/install.fish
    if test -f $installer
        source $installer
        __dft_persist_topic $topic
    end
end
