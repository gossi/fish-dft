function __dft_install -a topic -d 'install DFTFILE topic(s)'
    if test (count $argv) -gt 0
        __dft_install_topic $topic
    else
        __dft_install_all
    end
end