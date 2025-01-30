#!/bin/bash

blue=$(printf '\033[38;5;32m')
bold=$(printf '\033[1m')
normal=$(printf '\033[0m')

print_ok() {
	printf "%s[ OK ]%s\n" "${blue}" "${normal}"
}
