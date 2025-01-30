#!/bin/bash

source /etc/profile.d/_utils.sh

if test "$(id -u)" -eq "0"; then
	return 0
fi

if test -f /etc/linuxbrew.firstrun; then
	return 0
fi

if test -d /home/linuxbrew/.linuxbrew; then
	return 0
fi

name="$(hostname -s)"
linuxbrew_home="${XDG_DATA_HOME:-$HOME/.local/share}"/devbox/"${name}"
printf "\nSetting up linuxbrew...\t\t\t\t "
if test ! -d "${linuxbrew_home}"; then
	mkdir -p "${linuxbrew_home}"
	if test -d "${XDG_DATA_HOME:-$HOME/.local/share}"/devbox/.linuxbrew; then
		mv "${XDG_DATA_HOME:-$HOME/.local/share}"/devbox/.linuxbrew "${linuxbrew_home}"/.linuxbrew
	fi
fi
if test ! -d /home/linuxbrew; then
	sudo mkdir -p /home/linuxbrew
fi
sudo mount --bind "${linuxbrew_home}" /home/linuxbrew
sudo cp -R /home/homebrew/.linuxbrew /home/linuxbrew/
sudo chown -R "$(id -u)" /home/linuxbrew
unset linuxbrew_home
print_ok

# TODO: set up fish completions
if test ! -d /usr/local/share/bash-completion/completions; then
	printf "Setting up tab completions...\t\t\t "
	sudo mkdir -p /usr/local/share/bash-completion
	sudo mount --bind /run/host/usr/share/bash-completion /usr/local/share/bash-completion
	if test -x /run/host/usr/bin/ujust; then
		sudo ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/ujust
	fi
	print_ok
fi

# add brew taps
printf "Adding brew taps...\t\t\t\t "
brew bundle --no-lock --file=/dev/stdin <<EOF &>/dev/null
tap "homebrew/aliases"
tap "homebrew/bundle"
tap "homebrew/services"
EOF
print_ok

# install brew packages
printf "Installing brew packages...\t\t\t\t "
brew bundle --no-lock --quiet --file=/dev/stdin <<EOF &>/dev/null
brew "f3"
brew "fisher"
brew "mise"
brew "ncdu"
brew "smartmontools"
brew "wakeonlan"
EOF
print_ok

printf "\nlinuxbrew setup complete!\n\n"

sudo touch /etc/linuxbrew.firstrun
