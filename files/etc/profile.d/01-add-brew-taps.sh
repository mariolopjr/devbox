#!/bin/bash

source /etc/profile.d/_utils.sh

check_if_root() "$(id -u)"

# add brew taps
printf "Adding brew taps...\t\t\t\t "
brew bundle --no-lock --quiet --file=/dev/stdin <<EOF
tap "homebrew/aliases"
tap "homebrew/bundle"
tap "homebrew/services"
EOF
print_ok()
