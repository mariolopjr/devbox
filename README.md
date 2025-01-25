# devbox

**CI/CD my main development container, using boxkit**

This OCI container image is to be run as a [distrobox](https://github.com/89luca89/distrobox) using [podman](https://podman.io/) and a systemd [quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html).

This complements [westeros](https://github.com/mariolopjr/westeros) which is also CI/CD with various applications and configuration baked in and any user-facing configuration both for the main OS and the devbox via my [dotfiles](https://github.com/mariolopjr/dotfiles).

## How to use

- Drop a systemd [quadlet](https://github.com/ublue-os/toolboxes/blob/main/quadlets/wolfi-toolbox/wolfi-dx-distrobox-quadlet.container) file into `~/.config/containers/systemd`
- `systemctl --user daemon-reload`
- `systemctl --user enable --now container-mytoolbx.service`  # name of the service matches the quadlet file with the suffix of `.container` replaced with `.service`
- To get automatic updates you will need to enable `podman-auto-update.timer` which by default will auto-update at midnight

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/mariolopjr/devbox
```

## Attribution

This would not be possible without the work being done in the [Universal Blue Toolbox](https://github.com/ublue-os/toolboxes/tree/main/toolboxes/wolfi-toolbox) project.

Many things were blatantly copied from [aussielunix/mytoolbx](https://github.com/aussielunix/mytoolbx), hope you don't mind!
