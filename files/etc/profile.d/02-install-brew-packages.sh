#!/bin/bash

source /etc/profile.d/_utils.sh

check_if_root() "$(id -u)"

# install brew packages
printf "Installing brew packages...\t\t\t\t"
brew bundle --no-lock --file=/dev/stdin <<EOF
brew "f3"
brew "fisher"
brew "mise"
brew "ncdu"
brew "smartmontools"
brew "wakeonlan"
EOF

print_ok();

printf "\nlinuxbrew setup complete!\n\n"
