#!/bin/bash

blue=$(printf '\033[38;5;32m')
bold=$(printf '\033[1m')
normal=$(printf '\033[0m')

check_if_root() {
	if [ "$1" -eq 0 ]; then
		return
	fi
}

print_ok() {
	printf "%s[ OK ]%s\n" "${blue}" "${normal}"
}
