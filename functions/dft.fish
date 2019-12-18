function __dft_cleanup -d 'cleanup DFTFILEs'
    brew cleanup
end

function dft -a cmd -d 'dft topic manager'
    set -e argv[1]

    switch $cmd
        case install
            __dft_install $argv
            __dft_reload

        case uninstall
            __dft_uninstall_topic $argv
            __dft_reload

        case ls list
            __dft_ls

        case reload
            __dft_reload

        case up update upgrade
            __dft_update

        case cleanup
            __dft_cleanup

        case complete
            __dft_complete
    end
end