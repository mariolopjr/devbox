#!/bin/bash

source /etc/profile.d/_utils.sh

check_if_root() "$(id -u)"

if test ! -d /home/linuxbrew/.linuxbrew; then
	name="$(hostname -s)"
	linuxbrew_home="${XDG_DATA_HOME:-$HOME/.local/share}"/devbox/"${name}"
	printf "Setting up linuxbrew...\t\t\t\t "
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
	print_ok()
fi

# TODO: set up fish completions
if test ! -d /usr/local/share/bash-completion/completions; then
	printf "Setting up tab completions...\t\t\t "
	sudo mkdir -p /usr/local/share/bash-completion
	sudo mount --bind /run/host/usr/share/bash-completion /usr/local/share/bash-completion
	if test -x /run/host/usr/bin/ujust; then
		sudo ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/ujust
	fi
	print_ok()
fi

if test ! -f /etc/linuxbrew.firstrun; then
	sudo touch /etc/linuxbrew.firstrun
fi
