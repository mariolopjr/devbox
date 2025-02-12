#!/bin/sh

mkdir -p /usr/local/bin
ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak
ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman
ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/systemctl
ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/ddcutil
