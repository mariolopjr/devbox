#!/bin/sh

# Update the container and install packages
apk update && apk upgrade
grep -v '^#' ./devbox.packages | xargs apk add

# Get Distrobox-host-exec and host-spawn
git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox &&
	cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec &&
	cp /tmp/distrobox/distrobox-export /usr/bin/distrobox-export &&
	cp /tmp/distrobox/distrobox-init /usr/bin/entrypoint &&
	curl "https://github.com/1player/host-spawn/releases/download/$(grep 'host_spawn_version=' /tmp/distrobox/distrobox-host-exec | cut -d '"' -f 2)/host-spawn-$(uname -m) -o /usr/bin/host-spawn" &&
	chmod +x /usr/bin/host-spawn &&
	rm -rf /tmp/distrobox &&
	ln -fs /bin/sh /usr/bin/sh
