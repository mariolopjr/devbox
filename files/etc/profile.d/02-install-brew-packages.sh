#!/bin/bash

# install brew packages
brew bundle --no-lock --file=/dev/stdin <<EOF
brew "f3"
brew "fisher"
brew "mise"
brew "ncdu"
brew "smartmontools"
brew "wakeonlan"
EOF
