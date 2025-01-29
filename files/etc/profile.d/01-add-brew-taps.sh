#!/bin/bash

# install brew taps
brew bundle --no-lock --file=/dev/stdin <<EOF
tap "homebrew/aliases"
tap "homebrew/bundle"
tap "homebrew/services"
EOF
