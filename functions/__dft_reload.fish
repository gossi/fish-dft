function __dft_reload
    if test -f $HOME/.config/fish/config.fish
        source $HOME/.config/fish/config.fish
    end

    if test -f $HOME/.config/fish/conf.d/dft.fish
        source $HOME/.config/fish/conf.d/dft.fish
    end
end