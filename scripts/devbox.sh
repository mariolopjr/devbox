#!/bin/sh

# Update the container and install packages
apk update && apk upgrade
grep -v '^#' ./devbox.packages | xargs apk add

# Get Distrobox-host-exec and host-spawn
# TODO: fix shellcheck warnings
git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox &&
	cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec &&
	cp /tmp/distrobox/distrobox-export /usr/bin/distrobox-export &&
	cp /tmp/distrobox/distrobox-init /usr/bin/entrypoint &&
	wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn &&
	chmod +x /usr/bin/host-spawn &&
	rm -drf /tmp/distrobox &&
	ln -fs /bin/sh /usr/bin/sh

# Symlink distrobox shims
./distrobox-shims.sh
