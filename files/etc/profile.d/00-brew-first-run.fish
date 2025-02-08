#!/usr/bin/env fish

set blue (printf '\033[38;5;32m')
set bold (printf '\033[1m')
set normal (printf '\033[0m')

function print_ok
    printf "%s[ OK ]%s\n" "$blue" "$normal"
end

if test -f /etc/linuxbrew.firstrun
    exit 0
end

if test -d /home/linuxbrew/.linuxbrew
    exit 0
end

# remove fish built-in distrobox fish prompt
printf "\nremoving distrobox fish prompt...\t\t\t\t "
sudo sed -i '/function fish_prompt/,/end/d' /etc/fish/conf.d/distrobox_config.fish
print_ok

set name (hostname -s)
set linuxbrew_home (string join '' (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo $HOME/.local/share))"/devbox/$name"
printf "\nSetting up linuxbrew...\t\t\t\t "
if test ! -d "$linuxbrew_home"
    mkdir -p "$linuxbrew_home"
    if test -d (string join '' (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo $HOME/.local/share))"/devbox/.linuxbrew"
        mv (string join '' (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo $HOME/.local/share))"/devbox/.linuxbrew" "$linuxbrew_home/.linuxbrew"
    end
end
if test ! -d /home/linuxbrew
    sudo mkdir -p /home/linuxbrew
end
sudo mount --bind "$linuxbrew_home" /home/linuxbrew
sudo cp -R /home/homebrew/.linuxbrew /home/linuxbrew/
sudo chown -R (id -u) /home/linuxbrew
set -e linuxbrew_home
print_ok

# TODO: set up fish completions
if test ! -d /usr/local/share/bash-completion/completions
    printf "Setting up tab completions...\t\t\t "
    sudo mkdir -p /usr/local/share/bash-completion
    sudo mount --bind /run/host/usr/share/bash-completion /usr/local/share/bash-completion
    if test -x /run/host/usr/bin/ujust
        sudo ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/ujust
    end
    print_ok
end

# install brew packages
printf "Installing brew packages...\t\t\t "
brew bundle --no-lock --file=/etc/profile.d/packages.brew > /dev/null 2>&1
print_ok

printf "\nlinuxbrew setup complete!\n\n"


sudo touch /etc/linuxbrew.firstrun
