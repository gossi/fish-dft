function __dft_complete
    complete -ec dft
    complete -xc dft -n __fish_use_subcommand -a install -d "Install topic(s)"
    complete -xc dft -n __fish_use_subcommand -a uninstall -d "Uninstall topic"
    complete -xc dft -n __fish_use_subcommand -a ls -d "List installed topics"
    complete -xc dft -n __fish_use_subcommand -a update -d "Updates all topics"
    complete -xc dft -n __fish_use_subcommand -a cleanup -d "Cleans all topics"
    complete -xc dft -n __fish_use_subcommand -a reload -d "Reloads config for all installed topics"

    for topic in (dft ls)
        complete -xc dft -n "__fish_seen_subcommand_from uninstall" -a $topic
    end
end