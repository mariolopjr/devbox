#!/bin/sh

# Symlink distrobox shims
./distrobox-shims.sh

# Update the container and install packages
dnf update -y
grep -v '^#' ./devbox.packages | xargs dnf install -y

# ublue staging repo needed for brew, etc
dnf -y copr enable ublue-os/staging

# common packages installed to desktops
grep -v '^#' ./devbox.staging-packages | xargs dnf install -y

# only the packages above should come from testing
dnf -y copr disable ublue-os/staging

# TODO: install homebrew packages
