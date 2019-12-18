# fish-dft

Topic manager for dotfiles inside [fish shell](https://fishshell.com).

- Use `dft` to manage various technology stacks in your dotfiles
- Different setups for home, work... or any other location

## Installation

Use [fisher](https://github.com/jorgebucaran/fisher):

```bash
> fisher add gossi/fish-dft
```

## Manage Topics

Your topics are located in `~/.config/dft`. Each folder in there represents a
topic. There are special files for each topic.

Let's go through each of them at the example of a `php` topic:

```bash
> mkdir -p ~/config/dft/php
```

### Install

This file is executed when the topic is (re)installed. Think of it as a one-time
execution (though can be run twice).

File: `install.fish`

```bash
# install php
pecl install xdebug

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer self-update

# tools
composer global require phpunit/phpunit
composer global require friendsofphp/php-cs-fixer

# parallel downloads
composer global require hirak/prestissimo
```

Note: We are not focusing on `php` itself here in this step. We consider it done
by your os package manager (e.g. `brew` or `apt`). See section [yadm
integration](#yadm-integration).

Now that we have our topic defined and an install routine for it, we can install
it:

```bash
> dft install php
```

which will execute the commands above, e.g. additionally install composer and
some global packages.

### Configuration / Autoload

The config is what fish loads, usually what you would put manually in your
`.bashrc` (or equvalent).

File: `config.fish` (following fish file conventions here)

```bash
function phpunit
    php -dzend_extension=/usr/local/lib/php/pecl/20170718/xdebug.so (which phpunit) $argv
end
```

Note: Here we enable the xdebug engine explicitely for `phpunit`

You might want to update those configs at _runtime_. Then use `dft` to make
`fish` aware of it:

```bash
> dft reload
```

Note: The command `dft reload` works globally and not per topic

### Update

To update everything in the scope of your topic.

File: `update.fish`

```bash
composer global update
```

And call it via `dft`:

```bash
> dft update
```

Note: The command `dft update` works globally and not per topic

### Uninstall

Operations when a topic is uninstalled

File: `uninstall.fish`

```bash
rm /usr/local/bin/composer
```

And call it via `dft`:

```bash
> dft uninstall php
```

### List

List all currently installed topics

```bash
> dft ls
php
```

## Persistence

Whenever you (un)install a package, the list of currently installed packages is
kept in a dftfile at `~/.config/dft/dftfile`, this becomes very handy when
integrate `dft` with `yadm` (see next section).

If you run `dft install` it will run installers for each package found in the `dftfile`.

## YADM Integration

`dft` is built to work best with [`yadm`](https://yadm.io/). Here is how to best
then both together. Use:

**yadm**

- Manage your configs
- Use alternative files for your different locations (e.g. home as `default` and
  a `work` class).

**dft**

- Define various topics
- Connect `dft install` with `yadm bootstrap`

You may flately define a plathora of your topics and you may want to have
different alternate files for your `dftfile`

- `dftfile##default` - your topics for your home setup
- `dftfile##class.work` - your topics for your work setup

Link them both together in `yadm bootstrap`. Here is a sample `bootstrap` file
(assuming `brew`, `yadm` and `fish` are already installed):

```bash
#!/bin/bash

# Brew
system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then

  if [ -f "$HOME/.config/brew/Brewfile" ]; then
    echo "Updating homebrew bundle"
    brew bundle --file="$HOME/.config/brew/Brewfile"
  fi

fi

# iterm
defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.config/iterm2"

# Activate fish
echo $(which fish) | sudo tee -a /etc/shells > /dev/null
chsh -s $(which fish)

# Install fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fish -c fisher

# Install topics
fish -c 'dft install'
```

Use `brew` (rsp. `Brewfile`) to manage your os dependencies. Please make
suggestions in issues how `dft` can be linked up to it. At best `dftfile` and
`Brewfile` will stay in sync to some extent.

## Acknowledgments

I am a unicyclist. The danish national team in the freestyle discipline calls
themself the [Danish Freestyle Team](https://danishfreestyleteam.com/), abbreviated
by "dft". The name `dft` was also inspired by them :heart:
