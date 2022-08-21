set -q DFT_HOME
or set DFT_HOME $HOME/.config/dft
set -q DFTFILE
or set DFTFILE $DFT_HOME/dftfile

if test -f $DFTFILE
    set topics (/bin/cat $DFTFILE)
    for topic in $topics
        set -l config $DFT_HOME/$topic/config.fish
        if test -f $config
            source $config
        end
    end
end
