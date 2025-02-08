#!/bin/bash

blue=$(printf '\033[38;5;32m')
bold=$(printf '\033[1m')
normal=$(printf '\033[0m')

print_ok() {
	printf "%s[ OK ]%s\n" "${blue}" "${normal}"
}

if test -f /etc/linuxbrew.firstrun; then
	exit 0
fi

if test -d /home/linuxbrew/.linuxbrew; then
	exit 0
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

# install brew packages
printf "Installing brew packages...\t\t\t "
brew bundle --no-lock --file=/etc/profile.d/packages.brew >/dev/null 2>&1
print_ok

printf "\nlinuxbrew setup complete!\n\n"

sudo touch /etc/linuxbrew.firstrun
