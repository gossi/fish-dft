function __dft_ls
    if test -f $DFTFILE
        while read -la line
            echo $line
        end <$DFTFILE
    end
end